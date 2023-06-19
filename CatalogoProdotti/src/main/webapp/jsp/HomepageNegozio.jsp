<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="java.util.List"%>
<%@page import="com.azienda.catalogoProdotti.model.Utente"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Homepage Negozio</title>
</head>
<body>
<jsp:include page="/jsp/Menu.jsp"></jsp:include><br>
<%
	String baseUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	String carrello = baseUrl + "/visualizzaCarrello";
	//Utente utenteLoggato = (Utente)request.getAttribute("chiave_utente");
	Utente utenteLoggato = (Utente)session.getAttribute("chiave_utente");
	String urlAggiungiAlCarrello = request.getContextPath() + "/aggiungiAlCarrello";
	List<Prodotto> listaProdotti = (List<Prodotto>)request.getAttribute("chiave_listaProdottiUtente");
%>

	<h1>Mayone & Mayoni</h1>
	
	<h3>Ciao <%=utenteLoggato.getEmail() %></h3> <br>
	
	<a href="<%= carrello%>"> Visualizza carrello </a> 
	
	<h4> Elenco Prodotti</h4>
	<% if(request.getAttribute("Chiave_aggiornamento") != null) {%>
		<p> <%= request.getAttribute("Chiave_aggiornamento")%></p>
	<%} %>
	<%if(listaProdotti != null && listaProdotti.size()==0) {%> 	
 		<p> Lista prodotti vuota </p>
	<% } else { %> 
	<table border=1>
		<tr><th>Nome</th><th>Disponibiità</th><th>Prezzo</th><th>Immagine</th><th>Aggiungi al carrello</th></tr>
		<%for(Prodotto p : listaProdotti) {%>
		<%if(p.isCancellato() == false && p.getDisponibilita() >0) { %>		
		<tr><td><%= p.getNome()%></td><td><%=p.getDisponibilita() %></td><td><%= p.getPrezzo() %></td> <td></td>
	
			<td>
				<form action="<%= urlAggiungiAlCarrello %>" method="post">
				<input type="hidden" name="id" value="<%= p.getId() %>">
				<input type="submit" value="aggiungi">
				</form>
			</td>
		</tr>
		<%} %>	
	<%} %>
	</table>
<%} %>

	
</body>
</html>