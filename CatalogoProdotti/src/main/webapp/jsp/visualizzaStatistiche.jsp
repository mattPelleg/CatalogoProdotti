<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Statistiche acquisti</title>
</head>
<body>

<%
	Map<Prodotto, Integer> prodotto2quantita =(Map<Prodotto, Integer>) request.getAttribute("chiave_risultatoStatistiche");
	
	String baseUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	String homePageAdmin = baseUrl + "/jsp/HomepageAdmin.jsp";
	String visualizzaUtentiUrl = request.getContextPath()+ "/visualizzaUtenti";
	String ricercaProdottiUrl = baseUrl + "/jsp/RicercaProdotti.jsp";
%>
	<h1>Statistiche Acquisti</h1>
	
	<a href="<%= homePageAdmin%>"> HomePage Admin </a> &nbsp; &nbsp;
	<a href="<%= visualizzaUtentiUrl%>"> Visualizza utenti </a> &nbsp; &nbsp;
	<a href="<%= ricercaProdottiUrl%>"> Ricerca prodotti</a>
	
	
	<%if(prodotto2quantita.isEmpty()) {%> 	
 		<p> Mappa prodotti vuota </p>
	<% } else{ %> 
	<table border=1>
		<tr><th>Nome</th><th>N_VOLTE_ORDINATO</th><th>TOT_SPESO</th></tr>
		<%for(Prodotto p : prodotto2quantita.keySet()) {%>
		<tr><td><%= p.getNome()%></td><td><%=prodotto2quantita.get(p) %></td><td><%=prodotto2quantita.get(p) * p.getPrezzo() %></td></tr>
		<%} %>	
	</table>
<%} %>

</body>
</html>