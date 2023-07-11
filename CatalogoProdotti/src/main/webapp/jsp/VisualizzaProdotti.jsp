<%@page import="java.util.Map"%>
<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestione Prodotti</title>
<link rel="stylesheet" href="<%=request.getContextPath() + "/css/visualizzaProdotti.css" %>">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<body>

<% 
	String baseUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	String homePageAdmin = baseUrl + "/jsp/HomepageAdmin.jsp";
	String visualizzaUtentiUrl = request.getContextPath()+ "/visualizzaUtenti";
	String ricercaProdottiUrl = baseUrl + "/jsp/RicercaProdotti.jsp";
	String urlHomepage = baseUrl + "/jsp/Homepage.jsp";
// 	request.getServerPort() + request.getContextPath();
	String urlModifica = request.getContextPath() + "/goToModifica";
	String urlCancella = request.getContextPath() + "/delete";		
	String urlCreaProdotto = request.getContextPath() + "/creaProdotto";	
	List<Prodotto> listaProdotti = (List<Prodotto>)request.getAttribute("chiave_listaProdotti");
	
	Map <Integer, String> mappaImmagini = (Map <Integer, String>) request.getAttribute("chiave_mappaImmagini");
	String messaggioRisultatoModificaProdotto = (String) request.getAttribute("chiave_modificaProdotto");
	String messaggioRisultatoInserisciProdotto = (String) request.getAttribute("chiave_erroreInserisciProdotto");
	String urlRicercaProdotto = baseUrl + "/jsp/RicercaProdotti.jsp";
%>
<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left" style="display:none;z-index:2;width:40%;min-width:300px;background-color:#D3DDEA" id="mySidebar">
	<a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button">Chiudi il Menu</a>
	<a href="<%=urlHomepage%>" onclick="w3_close()" class="w3-bar-item w3-button">Home</a>
	
	<a href="<%=urlHomepage%>" onclick="w3_close()" class="w3-bar-item w3-button">Logout</a>
	<a href="<%=urlRicercaProdotto %>" onclick="w3_close()" class="w3-bar-item w3-button">Ricerca Prodotto</a>

	
</nav>

<div class="w3-top">
	<div class="w3-white w3-xlarge" style="max-width:1200px;margin: left">
		<div class="w3-button w3-padding-16 w3-left" onclick="w3_open()" style= "background-color:#2B91AD; ">☰</div>
		<div class="w3-center w3-padding-16" style="backbground-color: #CDECEF">

	<div class="visualizza" style="background-color: #CDECEF">
 	<jsp:include page="/jsp/MenuAdmin.jsp"></jsp:include> 
	</div>
	
	</div>
	</div>
</div>
	<h1>Pagina gestione prodotti</h1>

	<h1>Pagina gestione prodotti</h1>
	<h3>Form inserisci prodotto</h3>
	<div class="contenitore">
	<div id="cover">
	<form action="<%= urlCreaProdotto %>"method="post" enctype="multipart/form-data">
		<input type="text" name="nomeFormInput" placeholder= "Nome" required id="form">  <br>
		 <input type= "number" name= "disponibilitaFormInput" placeholder= "Disponibilità" required id="form"> <br>
		<input type= "number" step="0.01" name= "prezzoFormInput" placeholder= "Prezzo" required id="form"> <br>
		<div id="button">
		<input type="file" name="fileName" >
		<input type="submit" value="Salva">
		</div>
	</form>
	</div>
	<br><br>
	
	<!-- 	stampa un messaggio quando si modifica un prodotto -->
	<%if(messaggioRisultatoModificaProdotto != null) {%>
		<p> <%= messaggioRisultatoModificaProdotto%></p>
	<%} %>
	<!-- 	stampa un messaggio quando si aggiunge un prodotto  -->
	<%if(messaggioRisultatoInserisciProdotto != null) {%>
		 <p> <%= messaggioRisultatoInserisciProdotto%></p>
	<%} %>
	
	<%if(listaProdotti.size()==0) {%> 	
 		<p> Lista prodotti vuota </p>
	<% } else{ %> 
	<div class="container">
	<table border=1>
		<tr><th>NOME</th><th>DISPONIBILITÀ</th><th>PREZZO</th><th>IMMAGINE</th><th>MODIFICA</th><th>CANCELLA</th></tr>
		<%for(Prodotto p : listaProdotti) {%>
		<%if(p.isCancellato() == false) { %>
			<tr><td><%= p.getNome()%></td><td><%=p.getDisponibilita() %></td><td><%= p.getPrezzo() %></td> 
				<td><img alt="" src="<%= mappaImmagini.get(p.getId()) %>" width="100" height="100" ></td>
			<td>
				<form action="<%= urlModifica %>" method="post">
				<input type="hidden" name="id" value="<%= p.getId() %>">
				<input type="submit" value="modifica">
				</form>
			</td>
			
			<td>
				<form action="<%= urlCancella %>" method="post">
				<input type="hidden" name="id" value="<%= p.getId() %>">
				<input type="submit" value="cancella">
				</form>
			</td>
		</tr>
		<%} %>	
	<%} %>
	</table>
	</div>
</div>
<%} %>
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