<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="com.azienda.catalogoProdotti.model.Ordine"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ordini Uteneti</title>
</head>
<body>

<%
	String baseUrl = "http://" + request.getServerName() + ":" +
		request.getServerPort() + request.getContextPath();
	String homepageAdmin = baseUrl + "/jsp/HomepageAdmin.jsp";

	List<Ordine> listaOrdini =(List<Ordine>) request.getAttribute("chiave_risultatoOrdiniAdmin");
%>
	
	<h1>Gestione ordini utenti</h1>
	
	<nav>
		<a href="<%=homepageAdmin %>">Torna alla home</a> &nbsp;
	</nav>
	
	<%if(listaOrdini != null && listaOrdini.isEmpty()) {%> 	
 		<p> Lista ordini vuota </p>
	<% } else { %> 
	<table border=1>
		<tr><th>ID_UTENTE</th><th>EMAIL</th><th>ID_ORDINE</th><th>DATA_ACQUISTO</th><th>NOME</th><th>PREZZO</th><th>TOT</th></tr>
		<%for(Ordine o: listaOrdini) {%>
			<%float tot = 0f; %>
			<tr><td><%=o.getUtente().getId() %></td><td><%=o.getUtente().getEmail()%></td><td><%=o.getId() %></td><td><%=o.getDataAcquisto() %></td>
			<%for(Prodotto p: o.getListaOrdineProdotti()) {%>
				<%tot += p.getPrezzo(); %>
				<tr><td></td><td></td><td></td><td></td><td><%=p.getNome() %></td><td><%=p.getPrezzo() %></td>
			<%} %>
				<td><%=tot %></td>
				</tr>
			</tr>
	<%} %>
	</table>
<%} %>
	
</body>
</html>