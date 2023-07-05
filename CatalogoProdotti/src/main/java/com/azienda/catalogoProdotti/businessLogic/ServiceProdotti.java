package com.azienda.catalogoProdotti.businessLogic;

import java.sql.Blob;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;

import com.azienda.catalogoProdotti.dao.CarrelloDao;
import com.azienda.catalogoProdotti.dao.OrdineDao;
import com.azienda.catalogoProdotti.dao.ProdottoDao;
import com.azienda.catalogoProdotti.dao.ProfiloDao;
import com.azienda.catalogoProdotti.dao.UtenteDao;
import com.azienda.catalogoProdotti.exception.DatiNonValidiException;
import com.azienda.catalogoProdotti.exception.ProdottoDuplicatoException;
import com.azienda.catalogoProdotti.exception.ProdottoNonDisponibileException;
import com.azienda.catalogoProdotti.model.Carrello;
import com.azienda.catalogoProdotti.model.Ordine;
import com.azienda.catalogoProdotti.model.Prodotto;
import com.azienda.catalogoProdotti.model.Utente;

public class ServiceProdotti {
	private EntityManager em;

	private ProfiloDao profiloDao;
	private UtenteDao utenteDao;
	private ProdottoDao prodottoDao;
	private CarrelloDao carrelloDao;
	private OrdineDao ordineDao;

	public ServiceProdotti(EntityManager em, ProfiloDao profiloDao, UtenteDao utenteDao, ProdottoDao prodottoDao,
			CarrelloDao carrelloDao, OrdineDao ordineDao) {
		this.em = em;
		this.profiloDao = profiloDao;
		this.utenteDao = utenteDao;
		this.prodottoDao = prodottoDao;
		this.carrelloDao = carrelloDao;
		this.ordineDao = ordineDao;
	}

	/**
	 * Metodo che restituisce la lista di tutti i prodotti conenuti nel database
	 * 
	 * @retun la lista di prodotti
	 */
	public List<Prodotto> visualizzaProdotti() {
		return this.prodottoDao.retrieve();
	}

	/**
	 * Metodo che salva un prodotto nel database Vengono eseguiti i controlli sui
	 * parametri passati
	 * 
	 * @param nome          il nome del prodotto
	 * @param disponibilita la disponibilità del prodotto
	 * @param prezzo        il prezzo del prodotto
	 */
	public void salvaProdotto(String nome, Integer disponibilita, Float prezzo, Blob immagine, String nomeImmagine)
			throws Exception {
		try {
			em.getTransaction().begin();

			if (nome == null || nome.isBlank())
				throw new DatiNonValidiException("Il nome è obbligatorio!", null);

			if (disponibilita < 0)
				throw new DatiNonValidiException("La disponibilità deve essere maggiore o uguale a zero", null);

			if (prezzo < 0)
				throw new DatiNonValidiException("Il prezzo deve essere maggiore o uguale a zero", null);

			List<Prodotto> listaProdotti = prodottoDao.findProdottoByNome(nome);
			if (listaProdotti.size() > 0) {
				throw new ProdottoDuplicatoException("Il prodotto " + nome + " è già presente nell'elenco", null);
			} else {
				Prodotto p = new Prodotto(nome, disponibilita, prezzo);
				if (immagine != null) {
					p.setImmagine(immagine);
					p.setNomeImmagine(nomeImmagine);
				}
				prodottoDao.create(p);
			}
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			throw e;
		}
	}

	public Prodotto prelevaProdottoById(Integer id) {
		try {
			em.getTransaction().begin();
			Prodotto p = prodottoDao.findById(id);
			em.getTransaction().commit();
			return p;
		} catch (Exception e) {
			em.getTransaction().rollback();
			throw e;
		}
	}

	public void modifica(Integer id, String nome, Integer disp, Float prezzo) {
		try {
			em.getTransaction().begin();

			Prodotto prodottoDb = prodottoDao.findById(id);

			if (nome != null && !nome.isBlank()) {
				prodottoDb.setNome(nome);
			}

			if (disp >= 0) {
				prodottoDb.setDisponibilita(disp);
			}

			if (prezzo >= 0) {
				prodottoDb.setPrezzo(prezzo);
			}

			em.getTransaction().commit();

		} catch (Exception e) {
			em.getTransaction().rollback();
			throw e;
		}
	}

	public void cancella(Integer id) {
		try {
			em.getTransaction().begin();

			Prodotto prodottoDb = prodottoDao.findById(id);
			prodottoDb.setCancellato(true);

			prodottoDb.getListaCarrelli().clear();
			List<Carrello> listaTuttiCarrelli = carrelloDao.retrieve();
			for (Carrello c : listaTuttiCarrelli) {
				c.getListaProdottiCarrello().remove(prodottoDb);
			}

			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			throw e;
		}
	}

	/**
	 * Metodo che ricerca i prodotti in base al nome ed al prezzo, oppure in base
	 * solo al nome, o in base solo al prezzo o se entrambi sono campi vuoti allora
	 * restituisce tutti i prodotti
	 * 
	 * @param nome il nome del prodotto cercato
	 * @prezzo il prezzo del prodotto cercato
	 * 
	 * @return la lista con i prodotti cercati
	 */
	public List<Prodotto> ricercaProdotti(String nome, Float prezzo) {

		try {
			List<Prodotto> ricercaProdotti = new ArrayList<>();
			em.getTransaction().begin();

			if (nome != null && !nome.isBlank() && prezzo != null && prezzo > 0)
				ricercaProdotti = prodottoDao.findProdottoByNomeAndPrezzoLike(nome, prezzo);

			else if (nome != null && !nome.isBlank())
				ricercaProdotti = prodottoDao.findProdottoByNomeLike(nome);

			else if (prezzo != null && prezzo > 0)
				ricercaProdotti = prodottoDao.findProdottoByPrezzoLike(prezzo);

			else
				ricercaProdotti = prodottoDao.retrieve();

			em.getTransaction().commit();

			return ricercaProdotti;
		} catch (Exception e) {
			em.getTransaction().rollback();
			throw e;
		}
	}

	/**
	 * Metodo che aggiunge un prodotto al carrello del'ytente
	 * 
	 * @param idProdotto    l'id del prodotto da aggiungere
	 * @param utenteLoggato l'utente in sessione
	 * @throws Exception
	 */
	public void aggiungiAlCarrello(Integer idProdotto, Utente utenteLoggato) throws Exception {
		try {
			em.getTransaction().begin();

			// prendo l'utente dalla lista di utenti nel db, è un ulteriore controllo
			List<Utente> utentiDb = utenteDao.findUtenteById(utenteLoggato.getId());
			Utente utenteDb = utentiDb.get(0);

			// tramite l'id del prodotto, prendo il prodotto da aggiungere al carrello
			Prodotto prodottoDb = prodottoDao.findById(idProdotto);

			// prendo il carrello dell'utente
			Carrello carrelloUtente = utenteDb.getCarrelloUtente();

			// prima di aggiungere il prodotto nel carrello, controllo
			// se nel carrello dell'utente c'è già quel prodotto
			List<Prodotto> listaProdottiCarrelloUtente = carrelloUtente.getListaProdottiCarrello();
			if (listaProdottiCarrelloUtente.contains(prodottoDb))
				throw new ProdottoDuplicatoException("Il prodotto " + prodottoDb.getNome() + " è già nel carrello!",
						null);

			// e ci aggiungo il prodotto
			listaProdottiCarrelloUtente.add(prodottoDb);

			/*
			 * Adesso bisogna settare l'associazione tra prodotto - carrello dalla parte di
			 * prodotto (prodotto contiene la join table della relazione molti-molti)
			 */
			prodottoDb.getListaCarrelli().add(carrelloUtente);

			em.getTransaction().commit();

		} catch (Exception e) {
			em.getTransaction().rollback();
			throw e;
		}
	}

	public void rimuoviProdotto(Prodotto daRimuovere, Utente utente) {
		try {
			this.em.getTransaction().begin();

			// prendo il carrello dell'utente
			Carrello carrelloUtente = utente.getCarrelloUtente();

			// prendo la lista dei prodotti contenuti nel carrello
			List<Prodotto> prodottiNelCarrello = carrelloUtente.getListaProdottiCarrello();
			// rimuovo il carrello dal prodotto --> rimuove l'associazione carrello-prodotto
			prodottiNelCarrello.remove(daRimuovere);

			// rimuovo il prodotto dal carrello --> rimuove l'associazione prodotto-carrello
			daRimuovere.getListaCarrelli().remove(carrelloUtente);

			this.em.getTransaction().commit();

		} catch (Exception e) {
			this.em.getTransaction().rollback();
			throw e;
		}
	}

	public void creaOrdine(List<Prodotto> listaProdottiCarrello, Utente utenteInSessione) throws Exception {
		// TODO Auto-generated method stub
		try {

			this.em.getTransaction().begin();

			Ordine nuovoOrdine = new Ordine(LocalDate.now());
			nuovoOrdine.setUtente(utenteInSessione);

			List<Prodotto> prodottiNonDisponibili = new ArrayList<>();

			for (Prodotto p : listaProdottiCarrello) {

				if (p.getDisponibilita() == 0) {
					String s = "Il prodotto " + p.getNome() + 
							" non è più disponibile, il tuo carrello è stato aggiornato";
					throw new ProdottoNonDisponibileException(s, null);
				}
				nuovoOrdine.getListaOrdineProdotti().add(p);
				p.getListaOrdini().add(nuovoOrdine);

				p.setDisponibilita(p.getDisponibilita() - 1);

			}

			this.ordineDao.create(nuovoOrdine);

			this.em.getTransaction().commit();

		} catch (Exception e) {
			// TODO: handle exception
			this.em.getTransaction().rollback();
			throw e;
		}
	}

	public void svuotaCarrello(Utente utente) {
		try {
			this.em.getTransaction().begin();

			// prendo il carrello dell'utente
			Carrello carrelloUtente = utente.getCarrelloUtente();

			// prendo la lista dei prodotti contenuti nel carrello
			List<Prodotto> prodottiNelCarrello = carrelloUtente.getListaProdottiCarrello();

			for (Prodotto p : prodottiNelCarrello) {
				p.getListaCarrelli().clear();
			}

			prodottiNelCarrello.clear();

			this.em.getTransaction().commit();

		} catch (Exception e) {
			this.em.getTransaction().rollback();
			throw e;
		}
	}

	public List<Ordine> visualizzaOrdiniUtente(Utente u) {
		try {
			this.em.getTransaction().begin();

			List<Ordine> listaOrdiniUtente = this.ordineDao.findOrdiniUtente(u);

			this.em.getTransaction().commit();

			return listaOrdiniUtente;

		} catch (Exception e) {
			this.em.getTransaction().rollback();
			throw e;
		}
	}

	public List<Ordine> visualizzaOrdini() {
		return this.ordineDao.retrieve();
	}

	public Carrello carrelloUtente(Utente utente) {
		return this.em.createQuery("select c from Carrello c where c.utente = :idUtente", Carrello.class).
				setParameter("idUtente", utente).getSingleResult();
	}
	
	/*
	 * Creare una funzionalità statistica, per i soli utenti
	 * con profilo admin, che riporti per ogni prodotto il numero
	 * di acquisti effettuati ed il prezzo totale speso dagli utenti 
	 */
	public Map<Prodotto, Integer> contaProdottoOrdine(List<Prodotto> listaProdotti) {
		try {
			this.em.getTransaction().begin();
			int conta = 0;
			
			Map<Prodotto, Integer> prodotto2quantita = new HashMap<>();
			
			for(Prodotto p : listaProdotti) {
				List<Ordine> listaOrdiniDelProdotto = p.getListaOrdini();
				conta = 0;
				prodotto2quantita.put(p, 0);
				for(Ordine o : listaOrdiniDelProdotto) {
					if(o.getListaOrdineProdotti().contains(p)) {
						conta++;
						prodotto2quantita.put(p, conta);
					}
				}
			}

			this.em.getTransaction().commit();
			
			return prodotto2quantita;

		} catch (Exception e) {
			this.em.getTransaction().rollback();
			throw e;
		}
	}
	

}
