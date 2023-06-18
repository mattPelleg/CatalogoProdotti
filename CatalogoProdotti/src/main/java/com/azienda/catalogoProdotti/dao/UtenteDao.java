package com.azienda.catalogoProdotti.dao;

import java.util.List;

import javax.persistence.EntityManager;

import com.azienda.catalogoProdotti.model.Utente;

public class UtenteDao implements DaoInterface<Utente> {
	
	private EntityManager em;
	
	public UtenteDao(EntityManager em) {
		this.em = em;
	}

	@Override
	public void create(Utente object) {
		this.em.persist(object);
	}

	@Override
	public List<Utente> retrieve() {
		return this.em.createQuery("select u from Utente u", Utente.class).getResultList();
	}

	@Override
	public void update(Utente object) {
		this.em.persist(object);
	}

	@Override
	public void delete(Utente object) {
		this.em.remove(object);
	}

	/**
	 * Metodo che restituisce la lista di utenti
	 * cercando per email
	 * 
	 * @param email la mail dell'utente
	 * @return la lista di utenti
	 */
	public List<Utente> findUtenteByEmail(String email) {
		return this.em.createQuery("select u from Utente u where u.email = :parEmail", Utente.class).
				setParameter("parEmail", email).getResultList();
	}
	
	/**
	 * Metodo che restituisce la lista di utenti
	 * cercando per email e password
	 * 
	 * @param email la mail dell'utente
	 * @param password la password dell'utente
	 * @return la lista di utenti
	 */
	public List<Utente> findUtenteByEmailAndPassword(String email, String password) {
		return this.em.createQuery("select u from Utente u where u.email = :parEmail and u.password = :parPassword", Utente.class).
				setParameter("parEmail", email).setParameter("parPassword", password).getResultList();
	}

}
