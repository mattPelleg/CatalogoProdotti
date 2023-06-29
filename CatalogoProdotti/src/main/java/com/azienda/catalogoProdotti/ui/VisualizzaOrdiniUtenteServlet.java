package com.azienda.catalogoProdotti.ui;

import java.io.IOException;
import java.util.List;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.businessLogic.ServiceUtenti;
import com.azienda.catalogoProdotti.model.Ordine;
import com.azienda.catalogoProdotti.model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/visualizzaOrdiniUtente")
public class VisualizzaOrdiniUtenteServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			Utente utenteInSessione = (Utente) req.getSession().getAttribute("chiave_utente");
//			List<Ordine> listaOrdiniUtente = utenteInSessione.getListaOrdini();
			
			ServiceUtenti service = (ServiceUtenti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_UTENTE);
			Utente utente = service.cercaUtente(utenteInSessione.getEmail(), utenteInSessione.getPassword());
			List<Ordine> listaOrdiniUtente = utente.getListaOrdini();
//			List<Ordine> listaOrdiniUtente = service.visualizzaOrdiniUtente(utenteInSessione.getId());
			
			req.setAttribute("chiave_risultatoGetOrdiniUtente", listaOrdiniUtente);
			req.getRequestDispatcher("/jsp/VisualizzaOrdiniUtente.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();

		}
	}
}
