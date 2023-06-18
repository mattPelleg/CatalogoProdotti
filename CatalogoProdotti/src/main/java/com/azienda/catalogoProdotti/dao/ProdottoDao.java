package com.azienda.catalogoProdotti.dao;

import java.util.List;

import javax.persistence.EntityManager;

import com.azienda.catalogoProdotti.model.Prodotto;

public class ProdottoDao implements DaoInterface<Prodotto> {

	private EntityManager em;

	public ProdottoDao(EntityManager em) {
		this.em = em;
	}

	@Override
	public void create(Prodotto object) {
		this.em.persist(object);
	}

	@Override
	public List<Prodotto> retrieve() {
		return this.em.createQuery("select p from Prodotto p", Prodotto.class).getResultList();
	}

	@Override
	public void update(Prodotto object) {
		this.em.persist(object);
	}

	@Override
	public void delete(Prodotto object) {
		this.em.remove(object);
	}

	/**
	 * Restituisce la lista di prodotti contenuti nel database, cercandoli per nome
	 * 
	 * @param nome il nome del prodotto da cercare
	 * @return la lista con i prodotti cercati
	 */
	public List<Prodotto> findProdottoByNome(String nome) {
		return this.em.createQuery("select p from Prodotto p where p.nome = :parNome", Prodotto.class)
				.setParameter("parNome", nome).getResultList();
	}

	public List<Prodotto> findProdottoByNomeLike(String nome) {
		return this.em.createQuery("select p from Prodotto p where p.nome like :parNome", Prodotto.class)
				.setParameter("parNome", "%" + nome + "%").getResultList();
	}

	public List<Prodotto> findProdottoByPrezzoLike(Float prezzo) {
		return this.em.createQuery("select p from Prodotto p where p.prezzo = :parPrezzo", Prodotto.class)
				.setParameter("parPrezzo", prezzo).getResultList();
	}

	public List<Prodotto> findProdottoByNomeAndPrezzoLike(String nome, Float prezzo) {
		return this.em
				.createQuery("select p from Prodotto p where p.nome like :parNome and p.prezzo = :parPrezzo",
						Prodotto.class)
				.setParameter("parNome", "%" + nome + "%").setParameter("parPrezzo", prezzo).getResultList();
	}

	public Prodotto findById(Integer id) {
		return this.em.createQuery("select p from Prodotto p where p.id = :parId", Prodotto.class)
				.setParameter("parId", id).getSingleResult();
	}

}
