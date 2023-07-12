<%@page import="java.util.Map"%>
<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ricerca prodotti utente</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="stylesheet" href="<%=request.getContextPath() + "/css/RicercaProdottiStyle.css" %>">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
</head>
<body>

<%
	String homepageNegozioUrl = request.getContextPath() + "/visualizzaProdottiUtente";
	String urlAggiungiAlCarrello = request.getContextPath() + "/aggiungiAlCarrello";
	String formAction = request.getContextPath() + "/ricerca";

	List<Prodotto> listaProdotti = (List<Prodotto>) request.getAttribute("chiave_ricerca");
	Map<Integer, String> mappaImmagini = (Map <Integer, String>) request.getAttribute("chiave_mappaImmagini");

%>

	<h1>Ricerca Prodotti</h1>

	<!--TORNA ALLA HOME  -->
	<div class="wrapper" style="text-align:right">
		<a  class ="button" href="<%=homepageNegozioUrl %>">Torna alla home</a> &nbsp;
	</div>
	<svg style="visibility: hidden; position: absolute;" width="0" height="0" xmlns="http://www.w3.org/2000/svg" version="1.1">
    <defs>
        <filter id="goo"><feGaussianBlur in="SourceGraphic" stdDeviation="10" result="blur" />    
            <feColorMatrix in="blur" mode="matrix" values="1 0 0 0 0  0 1 0 0 0  0 0 1 0 0  0 0 0 19 -9" result="goo" />
            <feComposite in="SourceGraphic" in2="goo" operator="atop"/>
        </filter>
    </defs>
</svg>
	
 
 <div id="cover">
 <form action="<%= formAction %>" method="post"> 
     <input type="text" id="form" placeholder="Nome" name="nome">
       <input type="number" step= "0.01" id="form" placeholder="Prezzo" name="prezzo">
      <input type="submit" id="button" value="Enter">
      </form>
</div>
	
	 <h3>Risultato Ricerca</h3>
	<%if(listaProdotti != null && !listaProdotti.isEmpty()) {%> 	
	<div class="container">
	<table >
	<thead>
	<tr><th>Nome</th><th>Disponibiità</th><th>Prezzo</th><th>Immagine</th><th>Aggiungi al Carrello</th></tr>
	</thead>
	<tbody>
	<%for(Prodotto p : listaProdotti) {%>
		<%if(p.isCancellato() == false && p.getDisponibilita() > 0) { %>		
			<tr><td><%= p.getNome()%></td><td><%=p.getDisponibilita() %></td><td><%= p.getPrezzo() %></td> 
			<td><img alt="" src="<%= mappaImmagini.get(p.getId()) %>" width="100" height="100" ></td>
			<td>
				<form action="<%=urlAggiungiAlCarrello %>" method="post">
					<input type="hidden" name="idProdotto" value="<%= p.getId() %>">
					<input type="submit" value="Aggiungi">
				</form>
			</td>
		</tr>
		<%} %>	
	<%} %>
	</tbody>
	</table>
	</div>
<%} else {%>
	<p>Lista vuota, effettua una ricerca</p>
<%} %>

<%if(request.getAttribute("chiave_messaggio") != null) {%>
	<%=request.getAttribute("chiave_messaggio") %>
<%} %>
</body>
</html>