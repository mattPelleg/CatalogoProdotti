package com.azienda.catalogoProdotti.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

@Entity
public class Prodotto {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	private String nome;

	private Integer disponibilita;

	private Float prezzo;

//	Da aggiungere dopo
//	private String urlImmagine;

	private boolean cancellato = false;

	@ManyToMany
	@JoinTable(name = "ProdottoOrdine", joinColumns =
	@JoinColumn(name = "Id_Prodotto"), inverseJoinColumns =
	@JoinColumn(name = "Id_Ordine"))
	private List<Ordine> listaOrdini = new ArrayList<>();

	@ManyToMany
	@JoinTable(name = "ProdottoCarrello", joinColumns =
	@JoinColumn(name = "Id_Prodotto"), inverseJoinColumns =
	@JoinColumn(name = "Id_Carrello"))
	private List<Carrello> listaCarrelli = new ArrayList<>();

	public Prodotto() {
	}

	public Prodotto(String nome, Integer disponibilita, Float prezzo) {
		super();
		this.nome = nome;
		this.disponibilita = disponibilita;
		this.prezzo = prezzo;
	}

	public Integer getId() {
		return id;
	}

	public String getNome() {
		return nome;
	}

	public Integer getDisponibilita() {
		return disponibilita;
	}

	public Float getPrezzo() {
		return prezzo;
	}

	public boolean isCancellato() {
		return cancellato;
	}


	public void setId(Integer id) {
		this.id = id;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public void setDisponibilita(Integer disponibilita) {
		this.disponibilita = disponibilita;
	}

	public void setPrezzo(Float prezzo) {
		this.prezzo = prezzo;
	}

	public List<Ordine> getListaOrdini() {
		return listaOrdini;
	}

	public void setListaOrdini(List<Ordine> listaOrdini) {
		this.listaOrdini = listaOrdini;
	}

	public List<Carrello> getListaCarrelli() {
		return listaCarrelli;
	}

	public void setListaCarrelli(List<Carrello> listaCarrelli) {
		this.listaCarrelli = listaCarrelli;
	}

	public void setCancellato(boolean cancellato) {
		this.cancellato = cancellato;
	}

	@Override
	public String toString() {
		return "Prodotto [id=" + id + ", nome=" + nome + ", disponibilita=" + disponibilita + ", prezzo=" + prezzo
				+ "]";
	}

}
