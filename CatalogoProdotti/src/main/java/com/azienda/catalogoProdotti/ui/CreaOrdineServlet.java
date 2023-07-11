package com.azienda.catalogoProdotti.ui;

import java.io.IOException;
import java.security.Provider.Service;
import java.util.ArrayList;
import java.util.List;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.exception.ProdottoNonDisponibileException;
import com.azienda.catalogoProdotti.model.Ordine;
import com.azienda.catalogoProdotti.model.Prodotto;
import com.azienda.catalogoProdotti.model.Utente;
import com.azienda.catalogoProdotti.utils.ComparatoreProdottiPerNome;
import com.azienda.catalogoProdotti.utils.GestioneImmagini;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/creaOrdine")
public class CreaOrdineServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			Utente utenteInSessione = (Utente) req.getSession().getAttribute("chiave_utente");
			
			List<Prodotto> listaProdottiCarrello = utenteInSessione.getCarrelloUtente().getListaProdottiCarrello();
			List<Prodotto> prodotti = new ArrayList<>();
			prodotti.addAll(listaProdottiCarrello);
			
			prodotti.sort(new ComparatoreProdottiPerNome());
			GestioneImmagini.creaMappaImmagini(req, listaProdottiCarrello);
			
			ServiceProdotti service = (ServiceProdotti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
			service.creaOrdine(prodotti, utenteInSessione);
			service.svuotaCarrello(utenteInSessione);
			
			req.setAttribute("chiave_risultatoCreaOrdine", "Ordine confermato");
			req.getRequestDispatcher("/jsp/ProcediAllOrdine.jsp").forward(req, resp);
			
		} catch (ProdottoNonDisponibileException e) {
			req.setAttribute("chiave_risultatoCreaOrdine", e.getMessage());
			req.getRequestDispatcher("/jsp/ProcediAllOrdine.jsp").forward(req, resp);
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}
