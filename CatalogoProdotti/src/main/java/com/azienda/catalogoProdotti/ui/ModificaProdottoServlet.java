package com.azienda.catalogoProdotti.ui;

import java.io.IOException;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.businessLogic.ServiceUtenti;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/modifica")
public class ModificaProdottoServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String idString = req.getParameter("id");
			String nome = req.getParameter("nome");
			Integer disponibilita = Integer.parseInt(req.getParameter("disponibilita"));
			Float prezzo = Float.parseFloat(req.getParameter("prezzo"));

			Integer id = Integer.parseInt(idString);
			ServiceProdotti service = (ServiceProdotti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
			service.modifica(id, nome, disponibilita, prezzo);
			
			String message = "Aggiornamento effettuato";
//			req.setAttribute("chiave_risultatoModificaProdotto", message);
			resp.sendRedirect(req.getContextPath() + "/visualizzaProdotti?chiave_risultatoModificaProdotto=" + message);
			
		} catch (Exception e) {
			e.printStackTrace();
			String message = "Aggiornamento non effettuato, problema non previsto";
			req.setAttribute("chiave_risultatoModificaProdotto", message);
			req.getRequestDispatcher("jsp/DettagliProdotto.jsp").forward(req, resp);
		}
	
	}
}
