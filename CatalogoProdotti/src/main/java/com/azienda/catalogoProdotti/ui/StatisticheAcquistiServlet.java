package com.azienda.catalogoProdotti.ui;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.businessLogic.ServiceUtenti;
import com.azienda.catalogoProdotti.model.Prodotto;
import com.azienda.catalogoProdotti.model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/visualizzaStatistiche")
public class StatisticheAcquistiServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			
			ServiceProdotti service = (ServiceProdotti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
			Map<Prodotto, Integer> prodotti2quantita = service.contaProdottoOrdine(service.visualizzaProdotti());
			
			req.setAttribute("chiave_risultatoStatistiche", prodotti2quantita);
			req.getRequestDispatcher("jsp/visualizzaStatistiche.jsp").forward(req, resp);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
