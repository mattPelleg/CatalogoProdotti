package com.azienda.catalogoProdotti.dao;

import java.util.List;

import javax.persistence.EntityManager;

import com.azienda.catalogoProdotti.model.Profilo;

public class ProfiloDao implements DaoInterface<Profilo> {
	
	private EntityManager em;
	
	public ProfiloDao(EntityManager em) {
		this.em = em;
	}

	@Override
	public void create(Profilo object) {
		this.em.persist(object);
	}

	@Override
	public List<Profilo> retrieve() {
		return this.em.createQuery("select p from Profilo p", Profilo.class).getResultList();
	}

	@Override
	public void update(Profilo object) {
		this.em.persist(object);		
	}

	@Override
	public void delete(Profilo object) {
		this.em.remove(object);
	}

	public List<Profilo> findProfiloByNome(String nome) {
		  return this.em.createQuery("select p from Profilo p where p.nome = :parNome", Profilo.class).setParameter("parNome", nome).getResultList();
		 }



}
