package com.azienda.catalogoProdotti.businessLogic;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;

import com.azienda.catalogoProdotti.dao.CarrelloDao;
import com.azienda.catalogoProdotti.dao.OrdineDao;
import com.azienda.catalogoProdotti.dao.ProdottoDao;
import com.azienda.catalogoProdotti.dao.ProfiloDao;
import com.azienda.catalogoProdotti.dao.UtenteDao;
import com.azienda.catalogoProdotti.exception.DatiNonValidiException;
import com.azienda.catalogoProdotti.exception.ProdottoDuplicatoException;
import com.azienda.catalogoProdotti.model.Prodotto;

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
				throw new ProdottoDuplicatoException("Il prodotto " + nome + " è già presente nell'elenco", null);
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
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
			throw e;
		}
	}

	
	/**
	 * DA CORREGGERE:
	 * - ricerca con nome e prezzo vuoti va in eccezione
	 * - ricerca con solo il nome va in eccezione
	 * - ricerca con solo il prezzo, non da nessun risultato
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

}
