<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Statistiche acquisti</title>
<link rel="stylesheet" href="<%=request.getContextPath() + "/css/visualizzaStatistiche.css" %>">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<body>

<%
	Map<Prodotto, Integer> prodotto2quantita =(Map<Prodotto, Integer>) request.getAttribute("chiave_risultatoStatistiche");
	
	String baseUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	String homePageAdmin = baseUrl + "/jsp/HomepageAdmin.jsp";
	String visualizzaUtentiUrl = request.getContextPath()+ "/visualizzaUtenti";
	String ricercaProdottiUrl = baseUrl + "/jsp/RicercaProdotti.jsp";
	String homepageAdminUrl = request.getContextPath() + "/visualizzaProdotti";
%>
<p> Marcello</p>
	<h1>Statistiche Acquisti</h1>
	<div class="w3-top">
		<div class="visualizza" style="background-color: #FCD5CE">
<%-- 	 		<jsp:include page="/jsp/MenuAdmin.jsp"></jsp:include>  --%>
	 			<a href="<%= homePageAdmin%>"> HomePage Admin </a> &nbsp; &nbsp;
	<a href="<%= visualizzaUtentiUrl%>"> Visualizza utenti </a> &nbsp; &nbsp;
	<a href="<%= ricercaProdottiUrl%>"> Ricerca prodotti</a>
		</div>
	</div>
	

	<!--TORNA ALLA HOME  -->
	<div class="wrapper">
		<a  class ="button" href="<%=homepageAdminUrl %>">Torna alla home</a> &nbsp;
	</div>
	<svg style="visibility: hidden; position: absolute;" width="0" height="0" xmlns="http://www.w3.org/2000/svg" version="1.1">
    <defs>
        <filter id="goo"><feGaussianBlur in="SourceGraphic" stdDeviation="10" result="blur" />    
            <feColorMatrix in="blur" mode="matrix" values="1 0 0 0 0  0 1 0 0 0  0 0 1 0 0  0 0 0 19 -9" result="goo" />
            <feComposite in="SourceGraphic" in2="goo" operator="atop"/>
        </filter>
    </defs>
</svg>
	
	<%if(prodotto2quantita.isEmpty()) {%> 	
 		<p> Mappa prodotti vuota </p>
	<% } else{ %> 
	<div class="container">
	<table border=1>
		<tr><th>NOME</th><th>N_VOLTE_ORDINATO</th><th>TOT_SPESO</th></tr>
		<%for(Prodotto p : prodotto2quantita.keySet()) {%>
		<tr><td><%= p.getNome()%></td><td><%=prodotto2quantita.get(p) %></td><td><%=prodotto2quantita.get(p) * p.getPrezzo() %></td></tr>
		<%} %>	
	</table>
<%} %>
	</div>
</body>
</html>