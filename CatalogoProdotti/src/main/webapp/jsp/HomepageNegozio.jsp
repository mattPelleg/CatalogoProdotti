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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath() + "/css/homepageNegozio.css" %>">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">  
</head>
<body>
<%-- <jsp:include page="/jsp/Menu.jsp"></jsp:include><br> --%>


<%
	String baseUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	
	String carrello = baseUrl + "/visualizzaCarrello";
	String logoutUrl = baseUrl + "/jsp/Homepage.jsp";
	String ricercaProdotti = baseUrl + "/jsp/RicercaProdottiUtente.jsp";
	
	Utente utenteLoggato = (Utente)session.getAttribute("chiave_utente");
	String urlAggiungiAlCarrello = request.getContextPath() + "/aggiungiAlCarrello";
	String visualizzaOrdiniUtente = request.getContextPath() + "/visualizzaOrdiniUtente";
	// 	String ricercaProdotti = request.getContextPath() + "/ricerca";
		String urlHomepage = request.getContextPath() + "/logout";
	// 	request.getServerPort() + request.getContextPath();
	 
	List<Prodotto> listaProdotti = (List<Prodotto>)request.getAttribute("chiave_listaProdottiUtente");
	
	String messaggioRisultatoAggiungiAlCarrello = (String) request.getAttribute("chiave_risultatoAggiunta");
	Map<Integer, String> mappaImmagini = (Map <Integer, String>) request.getAttribute("chiave_mappaImmagini");

%>

<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left" style="display:none;z-index:2;width:40%;min-width:300px;background-color:#FCD5CE" id="mySidebar">
	<a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button">Chiudi il Menu</a>
<%-- 	<a href="<%=urlHomepage%>" onclick="w3_close()" class="w3-bar-item w3-button">Home</a> --%>
	
	<a href="<%=urlHomepage%>" onclick="w3_close()" class="w3-bar-item w3-button">Logout</a>
	<a href="<%=ricercaProdotti %>" onclick="w3_close()" class="w3-bar-item w3-button">Ricerca Prodotto</a>

	
</nav>

<div class="w3-top" style="background-color: #FCD5CE">
	<div class="w3-white w3-xlarge" style="max-width:1200px;margin: left; background-color:#FCD5CE;">
		<div class="w3-button w3-padding-16 w3-left" onclick="w3_open()" style= "background-color:#FCD5CE; ">☰</div>
 			<div class="w3-center w3-padding-16" style="background-color: #FCD5CE">

				<div class="visualizza" style="background-color: #FCD5CE">
			 			<a href="<%=carrello%>"> Visualizza carrello </a> &nbsp;
						<a href="<%=visualizzaOrdiniUtente%>"> Visualizza Ordini </a> &nbsp;
						<a href="<%=ricercaProdotti%>">Ricerca Prodotti</a> &nbsp; 
				</div>
		
			</div>
	</div>
</div>
<p>Marcello</p> <br>
<div class="titolo">
	<h1>Mayone & Mayoni</h1>
</div>
	<div class="benvenuto">
		<h3><em>Ciao <%=utenteLoggato.getEmail() %></em></h3> <br>
	</div>

	<div class="row">
		<div class="navbar">
			<h4>Elenco Prodotti</h4>

		</div>
		<div class="col">
		</div>
	</div>
	<!-- 	stampa messaggio risultato aggiungi prodotto al carrello -->
	<% if(messaggioRisultatoAggiungiAlCarrello != null) {%>
		<p> <%= messaggioRisultatoAggiungiAlCarrello%></p>
	<%} %>
	
	<%if(listaProdotti != null && listaProdotti.size()==0) {%> 	
 		<p> Lista prodotti vuota </p>
	<% } else { %> 
<div class="container">
		<table>
			<thead>
			<tr>
				<th>Nome</th><th>Disponibiità</th><th>Prezzo</th><th>Immagine</th><th>Aggiungi al carrello</th>
			</tr>
			</thead>
			<tbody>
			<%for(Prodotto p : listaProdotti) {%>
			<%if(p.isCancellato() == false && p.getDisponibilita() > 0) { %>		
			<tr><td><%= p.getNome()%></td><td><%=p.getDisponibilita() %></td><td><%= p.getPrezzo() %> €</td> 
			<td><img alt="" src="<%= mappaImmagini.get(p.getId()) %>" width="100" height="100" ></td>
				
				<td>
					<form action="<%= urlAggiungiAlCarrello %>" method="post" class="beige-button">
						<input type="hidden" name="idProdotto" value="<%= p.getId() %>">
						<input type="submit" value="aggiungi">
					</form>
				</td>
			</tr>
			<%} %>	
		<%} %>
		</tbody>
		</table>
	<%} %>
</div>
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