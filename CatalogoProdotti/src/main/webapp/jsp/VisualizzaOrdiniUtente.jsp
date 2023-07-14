<%@page import="java.util.Map"%>
<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="com.azienda.catalogoProdotti.model.Ordine"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Riepilogo Ordini</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="stylesheet" href="<%=request.getContextPath() + "/css/visualizzaCarrelloStyle.css" %>">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
</head>
<body>


<%
	String homepageNegozioUrl = request.getContextPath() + "/visualizzaProdottiUtente";
	Map <Integer, String> mappaImmagini = (Map <Integer, String>) request.getAttribute("chiave_mappaImmagini");

	List<Ordine> listaOrdiniUtente =(List<Ordine>) request.getAttribute("chiave_risultatoGetOrdiniUtente");
%>

<h1>Riepilogo Ordini</h1>

	<!--TORNA ALLA HOME  -->
	<div class="wrapper">
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


<%if(listaOrdiniUtente != null && listaOrdiniUtente.isEmpty()) {%> 	
 		<p> Lista ordini vuota </p>
	<% } else { %> 
	<div class="container">
	<table>
	<thead>
		<tr><th>ID_ORDINE</th><th>DATA_ACQUISTO</th><th>NOME</th><th>PREZZO</th><th>IMMAGINE</th><th>TOT</th></tr>
	</thead>
	<tbody>
		<%for(Ordine o: listaOrdiniUtente) {%>
			<%float tot = 0f; %>
			<tr><td><%=o.getId() %></td><td><%=o.getDataAcquisto() %></td><td></td><td></td><td></td><td></td>
			<%for(Prodotto p: o.getListaOrdineProdotti()) {%>
				<%tot += p.getPrezzo(); %>
				<tr><td></td><td></td><td><%=p.getNome() %></td><td><%=p.getPrezzo() %> €</td>
				<td><img alt="" src="<%= mappaImmagini.get(p.getId()) %>" width="100" height="100" ></td>
			<%} %>
				<td><%=tot %> €</td>
				</tr>
			</tr>
	<%} %>
	</tbody>
	</table>
<%} %>
</div>
</body>
</html>