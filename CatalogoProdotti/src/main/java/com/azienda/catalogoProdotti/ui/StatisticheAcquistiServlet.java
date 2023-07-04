package com.azienda.catalogoProdotti.ui;

import java.io.IOException;
import java.util.List;

import com.azienda.catalogoProdotti.businessLogic.ServiceUtenti;
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
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
