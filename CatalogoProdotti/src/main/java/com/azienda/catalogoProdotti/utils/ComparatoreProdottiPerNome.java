package com.azienda.catalogoProdotti.utils;

import java.util.Comparator;

import com.azienda.catalogoProdotti.model.Prodotto;

public class ComparatoreProdottiPerNome implements Comparator<Prodotto> {

	@Override
	public int compare(Prodotto o1, Prodotto o2) {
		return o1.getNome().compareTo(o2.getNome());
	}

}
