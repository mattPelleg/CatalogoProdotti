<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ordine</title>
</head>
<body>

<%
	String baseUrl = "http://" + request.getServerName() + ":" +
		request.getServerPort() + request.getContextPath();
	String homepageNegozioUrl = request.getContextPath() + "/visualizzaProdottiUtente";

	String urlCreaOrdine = request.getContextPath() + "/creaOrdine";

	String messaggioRisultatoCreaOrdine = (String) request.getAttribute("chiave_risultatoCreaOrdine");

	List<Prodotto> listaProdotti = (List<Prodotto>)session.getAttribute("chiave_listaProdottiCarrello");
%>


	<h1>Riepilogo Ordine</h1>
	
	<nav>
		<a href="<%=homepageNegozioUrl %>">Torna alla home</a> &nbsp;
	</nav>
	
	<%if(messaggioRisultatoCreaOrdine != null) {%>
		<p><%=messaggioRisultatoCreaOrdine %></p>
	<%} %>
	
	<%if(listaProdotti != null && listaProdotti.isEmpty()) {%> 	
 		<p> Nessun prodotto nel carrello </p>
	<% } else { %> 
	<table border=1>
		<tr><th>Nome</th><th>Prezzo</th><th>Immagine</th></tr>
		<%for(Prodotto p : listaProdotti) {%>
			<%if(p.isCancellato() == false) { %>		
			<tr>
				<td><%= p.getNome()%></td><td><%= p.getPrezzo() %></td> <td></td>
			</tr>
			<%} %>	
		<%} %>
		</table>
		<form action="<%=urlCreaOrdine %>" method="POST">
			<input type="submit" value="Conferma Ordine">
		</form>
	<%} %>
</body>
</html>