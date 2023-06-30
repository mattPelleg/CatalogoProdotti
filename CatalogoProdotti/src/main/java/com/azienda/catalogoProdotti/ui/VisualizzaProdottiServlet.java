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
			
			ServiceProdotti service = (ServiceProdotti) getServletContext()
					.getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);

			List<Prodotto> listaProdotti = service.visualizzaProdotti();

			req.setAttribute("chiave_listaProdotti", listaProdotti);

			if (req.getParameter("chiave_risultatoCancellaProdotto") != null) {
				// qui chiave_modificaProdotto si riferisce al risultato della cancellazione
				req.setAttribute("chiave_modificaProdotto", req.getParameter("chiave_risultatoCancellaProdotto"));
			}

			if (req.getParameter("chiave_risultatoModificaProdotto") != null) {
				req.setAttribute("chiave_modificaProdotto", req.getParameter("chiave_risultatoModificaProdotto"));
			}

			if (req.getAttribute("chiave_erroreCreaProdotto") != null) {
				req.setAttribute("chiave_erroreInserisciProdotto", req.getAttribute("chiave_erroreCreaProdotto"));
			}

			req.getRequestDispatcher("/jsp/VisualizzaProdotti.jsp").forward(req, resp);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
