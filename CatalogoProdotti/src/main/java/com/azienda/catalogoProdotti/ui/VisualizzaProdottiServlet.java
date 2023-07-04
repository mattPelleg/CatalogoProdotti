package com.azienda.catalogoProdotti.ui;

import java.io.File;
import java.io.IOException;
import java.sql.Blob;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.azienda.catalogoProdotti.businessLogic.ServiceProdotti;
import com.azienda.catalogoProdotti.model.Prodotto;
import com.azienda.catalogoProdotti.utils.BlobConverter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/visualizzaProdotti")
public class VisualizzaProdottiServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			ServiceProdotti service = (ServiceProdotti) getServletContext()
					.getAttribute(InitServlet.BUSINESS_LOGIC_PRODOTTO);

			List<Prodotto> listaProdotti = service.visualizzaProdotti();

			req.setAttribute("chiave_listaProdotti", listaProdotti);

			if (req.getParameter("chiave_risultatoCancellaProdotto") != null) {
				// qui chiave_modificaProdotto si riferisce al risultato della cancellazione
				req.setAttribute("chiave_modificaProdotto", req.getParameter("chiave_risultatoCancellaProdotto"));
			}

			if (req.getParameter("chiave_risultatoModificaProdotto") != null) {
				req.setAttribute("chiave_modificaProdotto", req.getParameter("chiave_risultatoModificaProdotto"));
			}

			if (req.getAttribute("chiave_erroreCreaProdotto") != null) {
				req.setAttribute("chiave_erroreInserisciProdotto", req.getAttribute("chiave_erroreCreaProdotto"));
			}

			creaMappaImmagini(req, listaProdotti);
			
			req.getRequestDispatcher("/jsp/VisualizzaProdotti.jsp").forward(req, resp);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void creaMappaImmagini(HttpServletRequest req, List<Prodotto> prodotti) throws Exception {

		Map<Integer, String> mappaImmagini = new HashMap<>();

		String uploadPath = getServletContext().getRealPath("") + File.separator + "tmpUpload";
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdir();
		}

		for (Prodotto p : prodotti) {

			String baseHttpUrl = "http://" + req.getServerName() + ":" + req.getServerPort() + req.getContextPath();

			Blob immagine = p.getImmagine();

			if (immagine != null) {

				String filePath = uploadPath + File.separator + p.getId() + "_" + p.getNomeImmagine();

				BlobConverter.saveFile(immagine, filePath);
				String imageUrl = baseHttpUrl + File.separator + "tmpUpload" + File.separator + p.getId() + "_"
						+ p.getNomeImmagine();
				mappaImmagini.put(p.getId(), imageUrl);

			} else {
				String imageUrl = baseHttpUrl + File.separator + "static" + File.separator + "imageNotFound.jpeg";
				mappaImmagini.put(p.getId(), imageUrl);
			}
		}
		req.setAttribute("chiave_mappaImmagini", mappaImmagini);
	}

}
