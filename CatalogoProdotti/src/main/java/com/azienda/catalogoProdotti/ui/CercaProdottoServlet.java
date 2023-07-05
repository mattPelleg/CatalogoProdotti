package com.azienda.catalogoProdotti.ui;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.model.Prodotto;
import com.azienda.catalogoProdotti.model.Utente;
import com.azienda.catalogoProdotti.utils.GestioneImmagini;

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
			Utente utenteInSessione = (Utente) req.getSession().getAttribute("chiave_utente");
			String ruoloUtente = utenteInSessione.getProfiloUtente().getNome();
			// nome e prezzo del prodotto da cercare
			String nome = req.getParameter("nome");
			/**
			 * Va in eccezione perchè quando non si inserisce niente nel campo prezzo, il
			 * parseFloat va in eccezione e quindi nel service non passiamo mai ai
			 * controlli, quindi bisonga aggiungere un controllo qui
			 */
			// prendo il prezzo inserito nella form di ricerca come stringa
			String prezzoStringa = req.getParameter("prezzo");
			Float prezzo;
			
			if(!prezzoStringa.isBlank())
				prezzo = Float.parseFloat(req.getParameter("prezzo"));
			else
				prezzo = null;
			
			ServiceProdotti service = (ServiceProdotti) getServletContext()
					.getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
			List<Prodotto> ricercaProdotti = service.ricercaProdotti(nome, prezzo);
			GestioneImmagini.creaMappaImmagini(req, ricercaProdotti);
			
//			Map<Prodotto, Integer> prodotto2quantita = service.contaProdottoOrdine(service.visualizzaProdotti());
//			for(Prodotto p : prodotto2quantita.keySet()) {
//				int c = prodotto2quantita.get(p);
//				System.out.println(p + " " + c);
//			}
				
			
			if (ruoloUtente.equals("admin")) {
				req.setAttribute("chiave_ricerca", ricercaProdotti);
				req.getRequestDispatcher("/jsp/RicercaProdotti.jsp").forward(req, resp);
			} 
			else if(ruoloUtente.equals("simpleUser")) {
				req.setAttribute("chiave_ricerca", ricercaProdotti);
				req.getRequestDispatcher("/jsp/RicercaProdottiUtente.jsp").forward(req, resp);
			}

		} catch (Exception e) {
			e.printStackTrace();
			String message = "Errore imprevisto";
			req.setAttribute("chiave_messaggio", message);
			req.getRequestDispatcher("jsp/RicercaProdotti.jsp").forward(req, resp);
		}
	}
}
