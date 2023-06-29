package com.azienda.catalogoProdotti.ui;

import java.io.IOException;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.model.Prodotto;
import com.azienda.catalogoProdotti.model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/rimuoviProdotto")
public class RimuoviProdotoCarrelloServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			
			Integer id = Integer.parseInt(req.getParameter("id"));
			Utente utente = (Utente)req.getSession().getAttribute("chiave_utente");
			ServiceProdotti service = (ServiceProdotti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
			
			Prodotto daRimuovere = service.prelevaProdottoById(id);
			service.rimuoviProdotto(daRimuovere, utente);
			
			String message = "Prodotto rimosso dal carrello";
			resp.sendRedirect(req.getContextPath() + "/visualizzaCarrello?chiave_risultatoRimuoviProdotto=" + message);
			
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}
}
