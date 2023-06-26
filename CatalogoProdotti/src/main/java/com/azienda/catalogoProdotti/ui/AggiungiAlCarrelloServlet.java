package com.azienda.catalogoProdotti.ui;

import java.io.IOException;

import javax.persistence.EntityManager;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.model.Carrello;
import com.azienda.catalogoProdotti.model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/aggiungiAlCarrello")
public class AggiungiAlCarrelloServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			//prendo i dati da homepageNegozio.jsp
//			String idStringa = req.getParameter("idProdotto");
//			Integer id = Integer.parseInt(idStringa);
			
			Integer idProdottoDaAggiungereAlCarrello = Integer.parseInt(req.getParameter("idProdotto"));
			ServiceProdotti service = (ServiceProdotti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
			
			Utente utente = (Utente)req.getSession().getAttribute("chiave_utente");
			service.aggiungiAlCarrello(idProdottoDaAggiungereAlCarrello, utente);
			
			String message = "Prodotto aggiunto al carrello";
			req.setAttribute("Chiave_messaggio", message);
			resp.sendRedirect(req.getContextPath() + "/visualizzaProdottiUtente?Chiave_messaggio=" + message);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}