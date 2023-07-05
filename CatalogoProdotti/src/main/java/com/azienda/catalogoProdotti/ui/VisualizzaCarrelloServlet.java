package com.azienda.catalogoProdotti.ui;

import java.io.File;
import java.io.IOException;
import java.sql.Blob;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.model.Carrello;
import com.azienda.catalogoProdotti.model.Prodotto;
import com.azienda.catalogoProdotti.model.Utente;
import com.azienda.catalogoProdotti.utils.BlobConverter;
import com.azienda.catalogoProdotti.utils.GestioneImmagini;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet ("/visualizzaCarrello")
public class VisualizzaCarrelloServlet extends HttpServlet {
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	doPost(req, resp);
}
@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			ServiceProdotti service = (ServiceProdotti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
			
			Utente utente = (Utente) req.getSession().getAttribute("chiave_utente");
			Carrello carrello = service.carrelloUtente(utente);
			
			List<Prodotto> listaProdottiCarrello = carrello.getListaProdottiCarrello(); //colleghiamo lista prodotti al carrello
			//se la lista è vuota invertire relazione o svuotare la cache em.clear
			
			GestioneImmagini.creaMappaImmagini(req, listaProdottiCarrello);
			
			req.setAttribute("chiave_listaCarrello", listaProdottiCarrello);
			req.setAttribute("chiave_risultatoRisultatoRimuoviProdottoCarrello", req.getParameter("chiave_risultatoRimuoviProdotto"));
			
			req.getSession().setAttribute("chiave_listaProdottiCarrello", listaProdottiCarrello);
			
			req.getRequestDispatcher("/jsp/VisualizzaCarrello.jsp").forward(req, resp);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}





}
