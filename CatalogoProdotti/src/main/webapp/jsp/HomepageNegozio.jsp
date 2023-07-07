<%@page import="java.util.Map"%>
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

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lobster&display=swap" rel="stylesheet">


<link rel="stylesheet" href="<%=request.getContextPath() + "/css/homepageNegozioStyle.css" %>">
</head>
<body>


<%
	String baseUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	
	String carrello = baseUrl + "/visualizzaCarrello";
	String logoutUrl = baseUrl + "/jsp/Homepage.jsp";
	String homepageUrl = baseUrl + "/jsp/Homepage.jsp";
	String ricercaProdotti = baseUrl + "/jsp/RicercaProdottiUtente.jsp";
	
	Utente utenteLoggato = (Utente)session.getAttribute("chiave_utente");
	String urlAggiungiAlCarrello = request.getContextPath() + "/aggiungiAlCarrello";
	String visualizzaOrdiniUtente = request.getContextPath() + "/visualizzaOrdiniUtente";
// 	String ricercaProdotti = request.getContextPath() + "/ricerca";
	
	List<Prodotto> listaProdotti = (List<Prodotto>)request.getAttribute("chiave_listaProdottiUtente");
	
	String messaggioRisultatoAggiungiAlCarrello = (String) request.getAttribute("chiave_risultatoAggiunta");
	Map<Integer, String> mappaImmagini = (Map <Integer, String>) request.getAttribute("chiave_mappaImmagini");

%>

<div id="gradient" />


<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left" style="display:none;z-index:2;width:40%;min-width:300px;" id="mySidebar">
        <a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button">Chiudi il Menu</a>
        <a href="<%=homepageUrl %>" onclick="w3_close()" class="w3-bar-item w3-button">Home</a>
        <a href="<%=visualizzaOrdiniUtente %>" onclick="w3_close()" class="w3-bar-item w3-button">Ordini</a>
        <a href="sitoCarino.html" onclick="w3_close()" class="w3-bar-item w3-button">Logout</a>
        <a href="#ricerca-prodotto" onclick="w3_close()" class="w3-bar-item w3-button">Ricerca Prodotto</a>
    </nav>

<div class="w3-top" style="background-color: seashell; padding: 1px 0 0 0">
	<div class="w3-white w3-xlarge" style="max-width:1200px;margin:auto">
		<div class="w3-button w3-padding-16 w3-left" onclick="w3_open()">☰</div>
		<div class="w3-center w3-padding-16"><h1>Mayone & Mayoni</h1></div>
	</div>
</div>


<!-- 	<h1>Mayone & Mayoni</h1> -->
	
	<div class="navigazione">
		<jsp:include page="/jsp/Menu.jsp"></jsp:include>
	</div>
	
	<div class="row1">
		<span class="row2">
			<h3>Ciao <%=utenteLoggato.getEmail() %></h3> 		
		</span>
		<div class="row3">
			<a href="<%=carrello%>"> Visualizza carrello </a>
			<a href="<%=visualizzaOrdiniUtente%>"> Visualizza Ordini </a>
			<a href="<%=ricercaProdotti%>">Ricerca Prodotti</a>
		</div>
	</div>
	
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
		<tr><td><%= p.getNome()%></td><td><%=p.getDisponibilita() %></td><td><%= p.getPrezzo() %></td> 
		<td><img alt="" src="<%= mappaImmagini.get(p.getId()) %>" width="100" height="100" ></td>
			
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
	
	
	
	
	
	
<script src="<%=request.getContextPath() + "/js/scriptSfondo.js" %>"></script>
	
<script>
        // Script to open and close sidebar
function w3_open() {
          document.getElementById("mySidebar").style.display = "block";
}
         
function w3_close() {
document.getElementById("mySidebar").style.display = "none";
}
</script>
</body>
</html>