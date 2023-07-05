package com.azienda.catalogoProdotti.ui;

import java.io.IOException;
import java.util.List;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.model.Prodotto;
import com.azienda.catalogoProdotti.utils.GestioneImmagini;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet ("/visualizzaProdottiUtente")
public class VisualizzaProdottiUtenteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			ServiceProdotti service = (ServiceProdotti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
			List<Prodotto> listaProdotti = service.visualizzaProdotti();
			
			GestioneImmagini.creaMappaImmagini(req, listaProdotti);
			
			req.setAttribute("chiave_listaProdottiUtente", listaProdotti);
			req.setAttribute("chiave_risultatoAggiunta", req.getParameter("chiave_risultatoAggiungiProdottoCarrello"));
			req.getRequestDispatcher("/jsp/HomepageNegozio.jsp").forward(req, resp);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

