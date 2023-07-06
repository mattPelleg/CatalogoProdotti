package com.azienda.catalogoProdotti.ui;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.businessLogic.ServiceUtenti;
import com.azienda.catalogoProdotti.dao.CarrelloDao;
import com.azienda.catalogoProdotti.dao.OrdineDao;
import com.azienda.catalogoProdotti.dao.ProdottoDao;
import com.azienda.catalogoProdotti.dao.ProfiloDao;
import com.azienda.catalogoProdotti.dao.UtenteDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

/**
 * Classe per l'inizializzazione della servlet principale, contiene tutte le
 * variabili del pattern DAO e la service
 * 
 * @see ServiceUtenti
 */

@WebServlet(value = "/Init", loadOnStartup = 1)
public class InitServlet extends HttpServlet {

	protected static final String BUSINESS_LOGIC_UTENTE = "businessLogicUtente";
	protected static final String BUSINESS_LOGIC_PRODOTTO = "businessLogicProdotto";
	
	@Override
	public void init() throws ServletException {

		EntityManager em = null;
		
		/*********************************
		  SCORREGGIA
		 *********************************/

		try {

			EntityManagerFactory emf = Persistence.createEntityManagerFactory("CatalogoProdotti");
			em = emf.createEntityManager();		//connessione al db, dopo questa riga posso già controllare il collegamento al db

			ProfiloDao profiloDao = new ProfiloDao(em);
			UtenteDao utenteDao = new UtenteDao(em);
			ProdottoDao prodottoDao = new ProdottoDao(em);
			CarrelloDao carrelloDao = new CarrelloDao(em);
			OrdineDao ordineDao = new OrdineDao(em);
			
			ServiceUtenti serviceUtenti = new ServiceUtenti(em, profiloDao, utenteDao, prodottoDao, carrelloDao, ordineDao);
			ServiceProdotti serviceProdotti = new ServiceProdotti(em, profiloDao, utenteDao, prodottoDao, carrelloDao, ordineDao);
			
			//Creazione admin e prodotti fissi
			serviceUtenti.salvaAdmin("admin@gmail.com", "admin");
			serviceUtenti.salvaUtente("matteo@gmail.com", "matteo");
			serviceUtenti.salvaUtente("marco@gmail.com", "marco");
			
			serviceProdotti.salvaProdotto("mayone", 3, 4f, null, null);
			serviceProdotti.salvaProdotto("felpone", 3, 5f, null, null);
			serviceProdotti.salvaProdotto("maglietta", 0, 5f, null, null);
			serviceProdotti.salvaProdotto("borsa", 1, 8f, null, null);
			serviceProdotti.salvaProdotto("cappello", 3, 2f, null, null);
			
			getServletContext().setAttribute(BUSINESS_LOGIC_UTENTE, serviceUtenti);
			getServletContext().setAttribute(BUSINESS_LOGIC_PRODOTTO, serviceProdotti);

		} catch (Exception e) {
			e.printStackTrace();
			em.close();
			System.exit(0);
		}
	}

}
