<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="com.azienda.catalogoProdotti.model.Utente"%>
<%@page import="java.util.List"%>
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
	String logoutUrl = baseUrl + "/jsp/Homepage.jsp";
	String ricercaProdotti = baseUrl + "/jsp/RicercaProdottiUtente.jsp";
	
	Utente utenteLoggato = (Utente)session.getAttribute("chiave_utente");
	String urlAggiungiAlCarrello = request.getContextPath() + "/aggiungiAlCarrello";
	String visualizzaOrdiniUtente = request.getContextPath() + "/visualizzaOrdiniUtente";
// 	String ricercaProdotti = request.getContextPath() + "/ricerca";
	
	List<Prodotto> listaProdotti = (List<Prodotto>)request.getAttribute("chiave_listaProdottiUtente");
	
	String messaggioRisultatoAggiungiAlCarrello = (String) request.getAttribute("chiave_risultatoAggiunta");
%>

	<h1>Mayone & Mayoni</h1>
	
	<h3>Ciao <%=utenteLoggato.getEmail() %></h3> <br>
	
	<a href="<%=carrello%>"> Visualizza carrello </a> &nbsp;
	<a href="<%=visualizzaOrdiniUtente%>"> Visualizza Ordini </a> &nbsp;
	<a href="<%=ricercaProdotti%>">Ricerca Prodotti</a> &nbsp;
	
	<h4>Elenco Prodotti</h4>
	
	<!-- 	stampa messaggio risultato aggiungi prodotto al carrello -->
	<% if(messaggioRisultatoAggiungiAlCarrello != null) {%>
		<p> <%= messaggioRisultatoAggiungiAlCarrello%></p>
	<%} %>
	
	<%if(listaProdotti != null && listaProdotti.size()==0) {%> 	
 		<p> Lista prodotti vuota </p>
	<% } else { %> 
	<table border=1>
		<tr><th>Nome</th><th>Disponibiità</th><th>Prezzo</th><th>Immagine</th><th>Aggiungi al carrello</th></tr>
		<%for(Prodotto p : listaProdotti) {%>
		<%if(p.isCancellato() == false && p.getDisponibilita() > 0) { %>		
		<tr><td><%= p.getNome()%></td><td><%=p.getDisponibilita() %></td><td><%= p.getPrezzo() %></td> <td></td>
			<td>
				<form action="<%= urlAggiungiAlCarrello %>" method="post">
					<input type="hidden" name="idProdotto" value="<%= p.getId() %>">
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