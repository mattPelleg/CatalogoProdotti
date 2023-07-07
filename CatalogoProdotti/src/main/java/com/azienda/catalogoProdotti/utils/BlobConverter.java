package com.azienda.catalogoProdotti.utils;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Blob;

import org.hibernate.engine.jdbc.BlobProxy;

public class BlobConverter {
	
	//conversione da file a blob
	public static Blob generateBlob(String filePath) throws Exception{
		InputStream is = new FileInputStream(filePath);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte [] buffer = new byte[1024];
		int byteLetti = -1;
		while ( (byteLetti = is.read(buffer, 0, buffer.length)) != -1)  {
			baos.write(buffer, 0, byteLetti);
		}
		baos.flush();
		byte [] data = baos.toByteArray();
		//genera un blob a partire da un array di byte
		Blob result = BlobProxy.generateProxy(data);
		baos.close();
		is.close();
		return result;
		
	}
	
	//conversione da blob a file
	public static void saveFile(Blob blob,String filePath) throws Exception {
		InputStream is = blob.getBinaryStream();
    	FileOutputStream fos = new FileOutputStream(filePath);
		byte [] buffer = new byte[1024];
		int read = -1;
		while ( (read = is.read(buffer, 0, buffer.length)) != -1)  {
			fos.write(buffer, 0, read);
		}
		fos.flush();
		fos.close();
	}
}
