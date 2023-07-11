package com.azienda.catalogoProdotti.utils;

import java.io.File;
import java.sql.Blob;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.azienda.catalogoProdotti.model.Prodotto;

import jakarta.servlet.http.HttpServletRequest;

public class GestioneImmagini {
	
	public static void creaMappaImmagini(HttpServletRequest req, List<Prodotto> prodotti) throws Exception {

		Map<Integer, String> mappaImmagini = new HashMap<>();

		String uploadPath = req.getServletContext().getRealPath("") + File.separator + "tmpUpload";
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
		req.getSession().setAttribute("chiave_mappaImmaginiSessione", mappaImmagini);
	}

}
