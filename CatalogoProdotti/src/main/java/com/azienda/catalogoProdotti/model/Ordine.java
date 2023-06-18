package com.azienda.catalogoProdotti.model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

@Entity
public class Ordine {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	private LocalDate dataAcquisto;

	@ManyToOne
	private Utente utente;

	@ManyToMany(mappedBy = "listaOrdini")
	private List<Prodotto> listaProdottiOrdine = new ArrayList<>();

	public Ordine() {
	}

	public Ordine(LocalDate dataAcquisto) {
		super();
		this.dataAcquisto = dataAcquisto;
	}

	public Integer getId() {
		return id;
	}

	public LocalDate getDataAcquisto() {
		return dataAcquisto;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setDataAcquisto(LocalDate dataAcquisto) {
		this.dataAcquisto = dataAcquisto;
	}

	public Utente getUtente() {
		return utente;
	}

	public List<Prodotto> getListaProdottiOrdine() {
		return listaProdottiOrdine;
	}

	public void setUtente(Utente utente) {
		this.utente = utente;
	}

	public void setListaProdottiOrdine(List<Prodotto> listaProdottiOrdine) {
		this.listaProdottiOrdine = listaProdottiOrdine;
	}

	@Override
	public String toString() {
		return "Ordine [id=" + id + ", dataAcquisto=" + dataAcquisto + "]";
	}

}
