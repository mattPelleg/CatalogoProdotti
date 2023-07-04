package com.azienda.catalogoProdotti.businessLogic;

import java.util.List;

import javax.persistence.EntityManager;

import com.azienda.catalogoProdotti.dao.CarrelloDao;
import com.azienda.catalogoProdotti.dao.OrdineDao;
import com.azienda.catalogoProdotti.dao.ProdottoDao;
import com.azienda.catalogoProdotti.dao.ProfiloDao;
import com.azienda.catalogoProdotti.dao.UtenteDao;
import com.azienda.catalogoProdotti.exception.DatiNonValidiException;
import com.azienda.catalogoProdotti.exception.UtenteDuplicatoException;
import com.azienda.catalogoProdotti.exception.UtenteNonRegistratoException;
import com.azienda.catalogoProdotti.model.Carrello;
import com.azienda.catalogoProdotti.model.Ordine;
import com.azienda.catalogoProdotti.model.Prodotto;
import com.azienda.catalogoProdotti.model.Profilo;
import com.azienda.catalogoProdotti.model.Utente;

public class ServiceUtenti {

	private EntityManager em;

	private ProfiloDao profiloDao;
	private UtenteDao utenteDao;
	private ProdottoDao prodottoDao;
	private CarrelloDao carrelloDao;
	private OrdineDao ordineDao;

	public ServiceUtenti(EntityManager em, ProfiloDao profiloDao, UtenteDao utenteDao, ProdottoDao prodottoDao,
			CarrelloDao carrelloDao, OrdineDao ordineDao) {
		this.em = em;
		this.profiloDao = profiloDao;
		this.utenteDao = utenteDao;
		this.prodottoDao = prodottoDao;
		this.carrelloDao = carrelloDao;
		this.ordineDao = ordineDao;
	}

	public Utente salvaUtente(String email, String password) throws Exception {
		try {
			em.getTransaction().begin();

			if (email == null || email.isBlank())
				throw new DatiNonValidiException("La mail è obbligatoria!", null);

			if (password == null || password.isBlank())
				throw new DatiNonValidiException("La password è obbligatoria!", null);

			List<Utente> listaUtenti = utenteDao.findUtenteByEmail(email);
			if (listaUtenti.size() > 0)
				throw new UtenteDuplicatoException("L'email " + email + " è già presente!", null);

			Utente u = new Utente(email, password);
			Profilo profilo;
			Carrello carrelloUtente = new Carrello();

			List<Profilo> listaProfilo = profiloDao.findProfiloByNome("simpleUser");
			if (listaProfilo.size() == 1) {
				profilo = listaProfilo.get(0);
				u.setProfiloUtente(profilo);
			} else {
				profilo = new Profilo("simpleUser");
				u.setProfiloUtente(profilo); // associa l'utente al profilo
				profiloDao.create(profilo);
			}

			u.setCarrelloUtente(carrelloUtente);
			utenteDao.create(u);
			carrelloDao.create(carrelloUtente);
			
			em.getTransaction().commit();

			return u;
		} catch (Exception e) {
			em.getTransaction().rollback();
			throw e;
		}
	}

	public Utente cercaUtente(String email, String password) throws Exception {
		try {
			em.getTransaction().begin();

			if (email == null || email.isBlank())
				throw new DatiNonValidiException("La mail è obbligatoria!", null);

			if (password == null || password.isBlank())
				throw new DatiNonValidiException("La password è obbligatoria!", null);

			List<Utente> listaUtenti = utenteDao.findUtenteByEmailAndPassword(email, password);
			if (listaUtenti.size() == 0)
				throw new UtenteNonRegistratoException("L'utente " + email + " non è registrato!", null);

			Utente utenteLoggato = listaUtenti.get(0);

			em.getTransaction().commit();

			return utenteLoggato;

		} catch (Exception e) {
			em.getTransaction().rollback();
			throw e;
		}
	}
	
	public Utente findUtenteById(Integer id) throws Exception {
		try {
			em.getTransaction().begin();

			this.em.clear();
			
			List<Utente> utente = utenteDao.findUtenteById(id);

			em.getTransaction().commit();
			
			return utente.get(0);

		} catch (Exception e) {
			em.getTransaction().rollback();
			throw e;
		}
	}

	public Utente salvaAdmin(String email, String password) throws Exception {
		try {
			em.getTransaction().begin();

			if (email == null || email.isBlank())
				throw new DatiNonValidiException("La mail è obbligatoria!", null);

			if (password == null || password.isBlank())
				throw new DatiNonValidiException("La password è obbligatoria!", null);

			List<Utente> listaUtenti = utenteDao.findUtenteByEmail(email);
			if (listaUtenti.size() > 0)
				throw new UtenteDuplicatoException("L'email " + email + " è già presente!", null);

			Utente u = new Utente(email, password);
			Profilo profilo;

			List<Profilo> listaProfilo = profiloDao.findProfiloByNome("admin");
			if (listaProfilo.size() == 1) {
				profilo = listaProfilo.get(0);
				u.setProfiloUtente(profilo);
			} else {
				profilo = new Profilo("admin");
				u.setProfiloUtente(profilo); // associ l'utente al profilo
			}

			utenteDao.create(u);
			profiloDao.create(profilo);

			em.getTransaction().commit();

			return u;
		} catch (Exception e) {
			em.getTransaction().rollback();
			throw e;
		}
	}

	public List<Utente> visualizzaUtenti() {
		return utenteDao.retrieve();
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
	 * Metodo che salva un prodotto nel database
	 * Vengono eseguiti i controlli sui parametri passati
	 * 
	 * @param nome il nome del prodotto
	 * @param disponibilita la disponibilità del prodotto
	 * @param prezzo il prezzo del prodotto
	 */
	public void salvaProdotto(String nome, Integer disponibilita, Float prezzo) throws Exception {
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
				Prodotto prodotto = listaProdotti.get(0);
				prodotto.setDisponibilita(prodotto.getDisponibilita() + disponibilita);																		// 1
				prodottoDao.update(prodotto);
			} else
				prodottoDao.create(new Prodotto(nome, disponibilita, prezzo));
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
			if(nome != null && !nome.isBlank()) {
				prodottoDb.setNome(nome);
			}
			if(disp >=  0) {
				prodottoDb.setDisponibilita(disp);
			}
			if(prezzo >= 0) {
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
			prodottoDao.delete(prodottoDb);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			throw e;
		}
	}

	public List<Ordine> visualizzaOrdini() {
		try {
			em.getTransaction().begin();
			
			List<Ordine> listaOrdini = ordineDao.retrieve();
			
			em.getTransaction().commit();
			
			return listaOrdini;
			
		} catch (Exception e) {
			em.getTransaction().rollback();
			throw e;
		}
	}
}
