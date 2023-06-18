package com.azienda.catalogoProdotti.ui;

import java.io.IOException;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.businessLogic.ServiceUtenti;
import com.azienda.catalogoProdotti.model.Prodotto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/goToModifica")
public class VaiAModifica extends HttpServlet{

		@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			doPost(req, resp);
		}

		@Override
		protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {
				String idString = req.getParameter("id");
				Integer id = Integer.parseInt(idString);
				ServiceProdotti service = (ServiceProdotti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
				
				Prodotto prodottoDaModificare = service.prelevaProdottoById(id);
				req.setAttribute("dettagliProdotto", prodottoDaModificare);
				req.getRequestDispatcher("jsp/DettagliProdotto.jsp").forward(req, resp);
				
			} catch (Exception e) {
				e.printStackTrace();
				req.setAttribute("erroreProdottoImprevisto", "Errore Imprevisto!");
				req.getRequestDispatcher("jsp/DettagliProdotto.jsp").forward(req, resp);
			}
		}
}
