package com.azienda.catalogoProdotti.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;

@Entity
public class Carrello {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@OneToOne(mappedBy = "carrelloUtente")
	private Utente utente;
	
	@ManyToMany(mappedBy = "listaCarrelli")
	private List<Prodotto> listaProdottiCarrello = new ArrayList<>();

	public Carrello() {
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Utente getUtente() {
		return utente;
	}

	public void setUtente(Utente utente) {
		this.utente = utente;
	}
	
	public List<Prodotto> getListaProdottiCarrello() {
		return listaProdottiCarrello;
	}

	public void setListaProdottiCarrello(List<Prodotto> listaProdottiCarrello) {
		this.listaProdottiCarrello = listaProdottiCarrello;
	}

	@Override
	public String toString() {
		return "Carrello [id=" + id + "]";
	}

}
