package com.azienda.catalogoProdotti.ui;

import java.io.File;
import java.io.IOException;
import java.sql.Blob;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.businessLogic.ServiceUtenti;
import com.azienda.catalogoProdotti.model.Ordine;
import com.azienda.catalogoProdotti.model.Prodotto;
import com.azienda.catalogoProdotti.model.Utente;
import com.azienda.catalogoProdotti.utils.BlobConverter;
import com.azienda.catalogoProdotti.utils.GestioneImmagini;

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

			ServiceProdotti service = (ServiceProdotti) getServletContext()
					.getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);

			List<Ordine> listaOrdiniUtente = service.visualizzaOrdiniUtente(utenteInSessione);

			for (Ordine o : listaOrdiniUtente) {
				GestioneImmagini.creaMappaImmagini(req, o.getListaOrdineProdotti());
			}

			req.setAttribute("chiave_risultatoGetOrdiniUtente", listaOrdiniUtente);
			req.getRequestDispatcher("/jsp/VisualizzaOrdiniUtente.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();

		}
	}

}
