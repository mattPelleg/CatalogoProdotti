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
			//QUI VA IN ECCEZIONE, DA RISOLVERE
			Float prezzo = Float.parseFloat(req.getParameter("prezzo"));
			ServiceProdotti service = (ServiceProdotti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
			List<Prodotto> ricercaProdotti = service.ricercaProdotti(nome,prezzo);

			req.setAttribute("Chiave_ricerca", ricercaProdotti);
			req.getRequestDispatcher("/jsp/RicercaProdotti.jsp").forward(req, resp);

		} catch (Exception e) {
			e.printStackTrace();
			String message = "Errore imprevisto";
			req.setAttribute("Chiave_messaggio", message);
			req.getRequestDispatcher("jsp/Messaggio.jsp").forward(req, resp);
		}
	}
}
