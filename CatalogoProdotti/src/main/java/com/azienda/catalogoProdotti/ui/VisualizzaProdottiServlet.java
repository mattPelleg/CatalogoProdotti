package com.azienda.catalogoProdotti.ui;

import java.io.IOException;
import java.util.List;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.businessLogic.ServiceUtenti;
import com.azienda.catalogoProdotti.model.Prodotto;
import com.azienda.catalogoProdotti.model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/visualizzaProdotti")
public class VisualizzaProdottiServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			ServiceProdotti service = (ServiceProdotti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
			List<Prodotto> listaProdotti = service.visualizzaProdotti();

			req.setAttribute("chiave_listaProdotti", listaProdotti);
			if(req.getAttribute("Chiave_messaggio") != null) {
				req.setAttribute("Chiave_aggiornamento", req.getAttribute("Chiave_messaggio"));
			}
			if(req.getAttribute("Chiave_errore") != null) {
				req.setAttribute("Chiave_aggiornamento", req.getAttribute("Chiave_errore"));
			}
			req.getRequestDispatcher("/jsp/VisualizzaProdotti.jsp").forward(req, resp);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
