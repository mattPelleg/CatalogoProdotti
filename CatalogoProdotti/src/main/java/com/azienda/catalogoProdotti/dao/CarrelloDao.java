package com.azienda.catalogoProdotti.dao;

import java.util.List;

import javax.persistence.EntityManager;

import com.azienda.catalogoProdotti.model.Carrello;
import com.azienda.catalogoProdotti.model.Prodotto;

public class CarrelloDao implements DaoInterface<Carrello>{
	
	private EntityManager em;
	
	public CarrelloDao(EntityManager em) {
		this.em = em;
	}

	/**
	 * Metodo per creare un carrello
	 * 
	 * @param object il carrello che viene creato
	 * @return il carrello creato
	 */
	@Override
	public void create(Carrello object) {
		this.em.persist(object);
	}

	@Override
	public List<Carrello> retrieve() {
		return this.em.createQuery("select c from Carrello c", Carrello.class).getResultList();
	}

	@Override
	public void update(Carrello object) {
		this.em.persist(object);
	}

	@Override
	public void delete(Carrello object) {
		this.em.remove(object);
	}
	
//	public List<Prodotto> cercaProdottiInCarrello(Integer idCarrello) {
//		return this.em.createQuery("select p from Prodotto p where p.id = :idProdotto", Prodotto.class).
//				setParameter("idProdotto", idProdotto).getResultList();
//		return this.em.createQuery("select p from Prodotto p where p.id = :idProdotto", Prodotto.class)
//				.setParameter("idProdotto", idProdotto).getResultList();
//		return this.em.createQuery("select p from Prodotto join p.carrello c where c.id = :idCarrello", Prodotto.class)
//			.setParameter("idProdotto", idCarrello).getResultList();
//
//	}
}
