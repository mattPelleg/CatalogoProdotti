package com.azienda.catalogoProdotti.ui;

import java.sql.Blob;

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
import com.azienda.catalogoProdotti.utils.BlobConverter;

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
	
	protected static final String PERCORSO_CARTELLA_FOTO = "/Users/matteopellegrini/Desktop/GENERATION/MAYONE/foto_progetto/";
	
	@Override
	public void init() throws ServletException {

		
		EntityManager em = null;
		

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
			
			Blob blobMaglione = BlobConverter.generateBlob(PERCORSO_CARTELLA_FOTO + "maglione.jpeg");
			String nomeMaglione = "maglione.jpeg";
			
			Blob blobGilet = BlobConverter.generateBlob(PERCORSO_CARTELLA_FOTO + "gilet.jpeg");
			String nomeGilet = "gilet.jpeg";
			
			Blob blobTop = BlobConverter.generateBlob(PERCORSO_CARTELLA_FOTO + "top.png");
			String nomeTop = "top.png";
			
			Blob blobBorsa = BlobConverter.generateBlob(PERCORSO_CARTELLA_FOTO + "borsa.jpeg");
			String nomeBorsa = "borsa.jpeg";
			
			Blob blobBerretto = BlobConverter.generateBlob(PERCORSO_CARTELLA_FOTO + "berretto.webp");
			String nomeBerretto = "berretto.webp";
			
			serviceProdotti.salvaProdotto("Maglione", 3, 20f, blobMaglione, nomeMaglione);
			serviceProdotti.salvaProdotto("Gilet", 3, 19f, blobGilet, nomeGilet);
			serviceProdotti.salvaProdotto("Top", 0, 17f, blobTop, nomeTop);
			serviceProdotti.salvaProdotto("Borsa", 1, 18f, blobBorsa, nomeBorsa);
			serviceProdotti.salvaProdotto("Berretto", 3, 24f, blobBerretto, nomeBerretto);
			
			getServletContext().setAttribute(BUSINESS_LOGIC_UTENTE, serviceUtenti);
			getServletContext().setAttribute(BUSINESS_LOGIC_PRODOTTO, serviceProdotti);

		} catch (Exception e) {
			e.printStackTrace();
			em.close();
			System.exit(0);
		}
	}

}
