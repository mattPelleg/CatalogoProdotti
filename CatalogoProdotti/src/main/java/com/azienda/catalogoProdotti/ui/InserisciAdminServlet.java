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

@WebServlet("/inserisciAdmin")
public class InserisciAdminServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String email = req.getParameter("emailAdminFormInput");
			String password = req.getParameter("passwordAdminFormInput");

			ServiceUtenti service = (ServiceUtenti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_UTENTE);
			Utente admin = service.salvaAdmin(email, password);

			if (admin != null) {
				req.setAttribute("chiave_adminInserito", "Inserimento admin riuscito");
				req.getRequestDispatcher("/jsp/HomepageAdmin.jsp").forward(req, resp);
			}

		} catch (DatiNonValidiException | UtenteDuplicatoException e) {
			e.printStackTrace();
			String messaggioEccezione = e.getMessage();
			req.setAttribute("chiave_errore", messaggioEccezione);
			req.getRequestDispatcher("/jsp/HomepageAdmin.jsp").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			req.getRequestDispatcher("/jsp/HomepageAdmin.jsp").forward(req, resp);
		}
	}

}
