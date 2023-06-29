package com.azienda.catalogoProdotti.ui;

import java.io.IOException;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.businessLogic.ServiceUtenti;
import com.azienda.catalogoProdotti.exception.DatiNonValidiException;
import com.azienda.catalogoProdotti.exception.ProdottoDuplicatoException;
import com.azienda.catalogoProdotti.exception.UtenteDuplicatoException;
import com.azienda.catalogoProdotti.model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/creaProdotto")
public class CreaProdottoServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			// recupero dati dalla form inserisci prodotto
			String nome = req.getParameter("nomeFormInput");
			Integer disponibilita = Integer.parseInt(req.getParameter("disponibilitaFormInput"));
			Float prezzo = Float.parseFloat(req.getParameter("prezzoFormInput"));
			
			// chiamata del metodo nella service
			ServiceProdotti service = (ServiceProdotti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
			service.salvaProdotto(nome, disponibilita, prezzo);

			// req.getRequestDispatcher("/jsp/VisualizzaProdotti.jsp").forward(req, resp);
			resp.sendRedirect(req.getContextPath() + "/visualizzaProdotti");

		} catch (DatiNonValidiException | ProdottoDuplicatoException e) {
			e.printStackTrace();
			String messaggioEccezione = e.getMessage();
			req.setAttribute("Chiave_errore", messaggioEccezione);
			req.getRequestDispatcher("/visualizzaProdotti").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			req.getRequestDispatcher("/jsp/VisualizzaProdotti.jsp").forward(req, resp);
		}
	}

}
