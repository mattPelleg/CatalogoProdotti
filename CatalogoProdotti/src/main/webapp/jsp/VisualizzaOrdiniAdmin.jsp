<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="com.azienda.catalogoProdotti.model.Ordine"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ordini Utenti</title>

<link rel="stylesheet" href="<%=request.getContextPath() + "/css/visualizzaOrdiniAdminStyle.css" %>">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<body>

<%
	String baseUrl = "http://" + request.getServerName() + ":" +
		request.getServerPort() + request.getContextPath();
	String homepageAdmin = baseUrl + "/jsp/HomepageAdmin.jsp";

	List<Ordine> listaOrdini =(List<Ordine>) request.getAttribute("chiave_risultatoOrdiniAdmin");
%>
	
<div class="titolo">
	<h1>Gestione ordini utenti</h1>
</div>

<div class="row">
	<div class="wrapper">
		<nav class="torna" style="color:#FFB5A7">
			<a class ="button"href="<%=homepageAdmin %>">Torna alla home</a>
		</nav>
			<svg style="visibility: hidden; position: absolute;" width="0" height="0" xmlns="http://www.w3.org/2000/svg" version="1.1">
    <defs>
        <filter id="goo"><feGaussianBlur in="SourceGraphic" stdDeviation="10" result="blur" />    
            <feColorMatrix in="blur" mode="matrix" values="1 0 0 0 0  0 1 0 0 0  0 0 1 0 0  0 0 0 19 -9" result="goo" />
            <feComposite in="SourceGraphic" in2="goo" operator="atop"/>
        </filter>
    </defs>
</svg>
	</div>
	<div class="col">
		<nav>
<%-- 			<a href="<%=homepageAdmin %>">Torna alla home</a> &nbsp; --%>
		</nav>
	</div>
</div>
	
<%if(listaOrdini != null && listaOrdini.isEmpty()) {%> 	
	<p> Lista ordini vuota </p>
<% } else { %> 
<div class="container">
	<table>
		<thead>
			<tr>
				<th>ID_UTENTE</th><th>EMAIL</th><th>ID_ORDINE</th><th>DATA_ACQUISTO</th><th>PRODOTTO</th><th>PREZZO</th>
<!-- 				<th>ID_UTENTE</th><th>EMAIL</th><th>ID_ORDINE</th><th>DATA_ACQUISTO</th><th>NOME</th><th>PREZZO</th><th>TOT</th> -->
			</tr>
		</thead>
		<tbody>
		<%for(Ordine o: listaOrdini) {%>
			<%float tot = 0f; %>
			<tr><td><%=o.getUtente().getId() %></td><td><%=o.getUtente().getEmail()%></td><td><%=o.getId() %></td><td><%=o.getDataAcquisto() %></td><td></td><td></td>
			<%for(Prodotto p: o.getListaOrdineProdotti()) {%>
				<%tot += p.getPrezzo(); %>
				<tr><td></td><td></td><td></td><td></td><td><%=p.getNome() %></td><td><%=p.getPrezzo() %> €</td>
			<%} %>
				</tr>
				<tr><td>TOT</td><td></td><td></td><td></td><td></td><td><%=tot %> €</td></tr>
			</tr>
		<%} %>
		
		</tbody>
	</table>
<%} %>
</div>

<!-- <div class="container"> -->
<!-- <table> -->
<!-- 	<thead> -->
<!--         <tr> -->
<!--             <th colspan="2">EMAIL_UTENTE</th> -->
<!--             <th>ID_ORDINE</th> -->
<!--             <th>DATA_ACQUISTO</th> -->
<!--             <th>PRODOTTO</th> -->
<!--             <th>PREZZO</th> -->
<!--         </tr> -->
<!-- 	</thead> -->
<!-- 	<tbody> -->
<%-- 	<%for(Ordine o: listaOrdini) {%> --%>
<%-- 		<%float tot = 0f; %> --%>
<!--         <tr> -->
<%--             <td colspan="2" rowspan="<%=o.getListaOrdineProdotti().size() %>"><%=o.getUtente().getEmail() %></td> --%>
<%-- 			<%for(Prodotto p: o.getListaOrdineProdotti()) {%> --%>
<%-- 			<%tot += p.getPrezzo(); %> --%>
<%--             <td><%=o.getId() %></td> --%>
<%--             <td><%=o.getDataAcquisto() %></td> --%>
<%--             <td><%=p.getNome() %></td> --%>
<%--             <td><%=p.getPrezzo() %></td> --%>
<!--         </tr>	 -->
<%-- 		<%} %> --%>
<%-- 	<%} %> --%>
<!-- 	</tbody> -->
<!--     </table> -->
<%-- <%} %> --%>
<!-- </div> -->

	
</body>
</html>