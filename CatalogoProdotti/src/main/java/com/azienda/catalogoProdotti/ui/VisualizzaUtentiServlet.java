package com.azienda.catalogoProdotti.ui;

import java.io.IOException;
import java.util.List;

import com.azienda.catalogoProdotti.businessLogic.ServiceUtenti;
import com.azienda.catalogoProdotti.model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/visualizzaUtenti")
public class VisualizzaUtentiServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			ServiceUtenti service = (ServiceUtenti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_UTENTE);
			List<Utente> listaUtenti = service.visualizzaUtenti();

			req.setAttribute("chiave_listaUtenti", listaUtenti);
			req.getRequestDispatcher("/jsp/VisualizzaUtenti.jsp").forward(req, resp);
			// controllo se la lista è vuota
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
