package com.azienda.catalogoProdotti.ui;

import java.io.IOException;

import com.azienda.catalogoProdotti.businessLogic.ServiceUtenti;
import com.azienda.catalogoProdotti.exception.DatiNonValidiException;
import com.azienda.catalogoProdotti.exception.UtenteDuplicatoException;
import com.azienda.catalogoProdotti.model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/registrazione")
public class InserisciUtenteServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//recupero dati dalla form jsp
			String email = req.getParameter("emailFormInput");
			String password = req.getParameter("passwordFormInput");
			
			//chiamata del metodo nella service
			ServiceUtenti service = (ServiceUtenti)getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_UTENTE);
			service.salvaUtente(email, password);
			
			//risposta
			Utente utente = new Utente(email, password); 
			
			if(utente != null) {
				req.setAttribute("chiave_utente", utente);
				req.getRequestDispatcher("/jsp/Login.jsp").forward(req, resp);
			}
			
			
		} catch (DatiNonValidiException | UtenteDuplicatoException e) {
			e.printStackTrace();
			String messaggioEccezione = e.getMessage();
			req.setAttribute("chiave_errore", messaggioEccezione);
			req.getRequestDispatcher("/jsp/Registrazione.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			req.getRequestDispatcher("/jsp/Registrazione.jsp").forward(req, resp);
		}
 	}

}
