package com.azienda.catalogoProdotti.ui;

import java.io.IOException;
import java.util.List;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.model.Carrello;
import com.azienda.catalogoProdotti.model.Prodotto;
import com.azienda.catalogoProdotti.model.Utente;

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
			
			//List<Prodotto> listaProdotti = service.visualizzaProdottiCarrello();
			Utente utente = (Utente) req.getSession().getAttribute("chiave_utente");
			Carrello carrello = utente.getCarrelloUtente();
			
			List<Prodotto> listaProdottiCarrello = carrello.getListaProdottiCarrello(); //colleghiamo lista prodotti al carrello
			//se la lista è vuota invertire relazione o svuotare la cache em.clear
			
			req.setAttribute("chiave_listaCarrello", listaProdottiCarrello);
			req.setAttribute("chiave_risultatoRisultatoRimuoviProdottoCarrello", req.getParameter("chiave_risultatoRimuoviProdotto"));
			req.getRequestDispatcher("/jsp/VisualizzaCarrello.jsp").forward(req, resp);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
