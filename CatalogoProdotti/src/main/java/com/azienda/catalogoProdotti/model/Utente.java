package com.azienda.catalogoProdotti.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Utente {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

//	private String username;

	private String password;

	private String email;

	@ManyToOne
	private Profilo profiloUtente;

	@OneToOne
	private Carrello carrelloUtente;

	@OneToMany(mappedBy = "utente")
	private List<Ordine> listaOrdini = new ArrayList<>();

	public Utente() {
	}

	public Utente(String email, String password) {
//		this.username = username;
		this.password = password;
		this.email = email;
	}

	public Integer getId() {
		return id;
	}

//	public String getUsername() {
//		return username;
//	}

	public String getPassword() {
		return password;
	}

	public String getEmail() {
		return email;
	}

	public void setId(Integer id) {
		this.id = id;
	}

//	public void setUsername(String username) {
//		this.username = username;
//	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Profilo getProfiloUtente() {
		return profiloUtente;
	}

	public void setProfiloUtente(Profilo profiloUtente) {
		this.profiloUtente = profiloUtente;
	}

	public Carrello getCarrelloUtente() {
		return carrelloUtente;
	}

	public void setCarrelloUtente(Carrello carrelloUtente) {
		this.carrelloUtente = carrelloUtente;
	}

	public List<Ordine> getListaOrdini() {
		return listaOrdini;
	}

	public void setListaOrdini(List<Ordine> listaOrdini) {
		this.listaOrdini = listaOrdini;
	}

	@Override
	public String toString() {
		return "Utente [id=" + id + ", email=" + email + ", password=" + password + "]";
	}

}
