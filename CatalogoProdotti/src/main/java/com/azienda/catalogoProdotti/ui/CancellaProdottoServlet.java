package com.azienda.catalogoProdotti.ui;

import java.io.IOException;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.businessLogic.ServiceUtenti;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/delete")
public class CancellaProdottoServlet extends HttpServlet {
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
			service.cancella(id);
			
			String message = "Cancellazione effettuata";
			resp.sendRedirect(req.getContextPath() + "/visualizzaCarrello?chiave_risultatoCancellaProdotto=" + message);
			
		} catch (Exception e) {
			e.printStackTrace();
			String message = "Cancellazione non effettuata, problema non previsto";
			req.setAttribute("chiave_risultatoCancellaProdotto", message);
			req.getRequestDispatcher("/visualizzaProdotti").forward(req, resp);
		}
	}
}
