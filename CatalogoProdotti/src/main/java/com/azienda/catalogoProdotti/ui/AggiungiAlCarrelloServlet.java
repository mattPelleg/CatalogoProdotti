package com.azienda.catalogoProdotti.ui;

import java.io.IOException;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/")
public class AggiungiAlCarrelloServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String idStringa = req.getParameter("id");
			Integer id = Integer.parseInt(idStringa);
			ServiceProdotti service = (ServiceProdotti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
			
			Utente utente = (Utente)req.getSession().getAttribute("chiave_utente");
			service.aggiungiAlCarrello(id, utente);
			
			req.setAttribute("chiave_messaggio", "Prodotto aggiunto al carrello");
			resp.sendRedirect(req.getContextPath() + "visualizzaProdottiUtente?chiave_messaggio=Prodotto aggiunto al carrello");
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}