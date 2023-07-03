package com.azienda.catalogoProdotti.ui;

import java.io.File;
import java.io.IOException;
import java.sql.Blob;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.businessLogic.ServiceUtenti;
import com.azienda.catalogoProdotti.exception.DatiNonValidiException;
import com.azienda.catalogoProdotti.exception.ProdottoDuplicatoException;
import com.azienda.catalogoProdotti.exception.UtenteDuplicatoException;
import com.azienda.catalogoProdotti.model.Utente;
import com.azienda.catalogoProdotti.utils.BlobConverter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/creaProdotto")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
				 maxFileSize = 1024 * 1024 * 10,
				 maxRequestSize = 1024 * 1024 * 10 * 5)
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
			Blob immagine = null;
			String nomeImmagine = null;
			
			String uploadPath = getServletContext().getRealPath("") + File.separator + "tmpUpload";
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdir();
			}
			
			String filePath = null;
			for ( Part part : req.getParts() ) {
				nomeImmagine = part.getSubmittedFileName();
				if ( nomeImmagine!=null && !nomeImmagine.isEmpty() ) {
					filePath = uploadPath + File.separator + nomeImmagine;
					part.write(filePath);
					immagine = BlobConverter.generateBlob(filePath);
				}
			}
			
			// chiamata del metodo nella service
			ServiceProdotti service = (ServiceProdotti) getServletContext().getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);
			service.salvaProdotto(nome, disponibilita, prezzo, immagine, nomeImmagine);

			// req.getRequestDispatcher("/jsp/VisualizzaProdotti.jsp").forward(req, resp);
			resp.sendRedirect(req.getContextPath() + "/visualizzaProdotti");

		} catch (DatiNonValidiException | ProdottoDuplicatoException e) {
			e.printStackTrace();
			String messaggioEccezione = e.getMessage();
			req.setAttribute("chiave_erroreCreaProdotto", messaggioEccezione);
			req.getRequestDispatcher("/visualizzaProdotti").forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			req.getRequestDispatcher("/jsp/VisualizzaProdotti.jsp").forward(req, resp);
		}
	}

}
