package com.azienda.catalogoProdotti.ui;

import java.io.IOException;
import java.util.List;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.model.Prodotto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ricerca")
public class CercaProdottoServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String nome = req.getParameter("nome");
			/**
			 * Va in eccezione perchè quando non si inserisce niente nel campo
			 * prezzo, il parseFloat va in eccezione e quindi nel service non 
			 * passiamo mai ai controlli, quindi bisonga aggiungere un controllo qui
			 */
			//prendo il prezzo inserito nella form di ricerca come stringa
			String prezzoStringa = req.getParameter("prezzo");
			//se è diversa da isBlank, ovvero è stato inserito un valore
			if(!prezzoStringa.isBlank()) {
				//mi prendo il float con il parse float
				Float prezzo = Float.parseFloat(req.getParameter("prezzo"));
				
				//e cerco la lista di prodotti con il prezzo float
				ServiceProdotti service = (ServiceProdotti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
				List<Prodotto> ricercaProdotti = service.ricercaProdotti(nome, prezzo);
				req.setAttribute("chiave_ricerca", ricercaProdotti);
				req.getRequestDispatcher("/jsp/RicercaProdotti.jsp").forward(req, resp);
			}
			else {
				//se invece non è stato inserito un valore nella form
				//uso come valore del prezzo un float = a null
				Float prezzoNull = null;
				ServiceProdotti service = (ServiceProdotti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
				List<Prodotto> ricercaProdotti = service.ricercaProdotti(nome, prezzoNull);
				req.setAttribute("chiave_ricerca", ricercaProdotti);
				req.getRequestDispatcher("/jsp/RicercaProdotti.jsp").forward(req, resp);
				
			}
				


		} catch (Exception e) {
			e.printStackTrace();
			String message = "Errore imprevisto";
			req.setAttribute("chiave_messaggio", message);
			req.getRequestDispatcher("jsp/RicercaProdotti.jsp").forward(req, resp);
		}
	}
}
