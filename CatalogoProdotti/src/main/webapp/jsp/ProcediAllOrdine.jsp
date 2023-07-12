<%@page import="java.util.Map"%>
<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ordine</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">

<link rel="stylesheet" href="<%=request.getContextPath() + "/css/procediOrdine.css" %>">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">

</head>
<body>

<%
	String baseUrl = "http://" + request.getServerName() + ":" +
		request.getServerPort() + request.getContextPath();

	String homepageNegozioUrl = request.getContextPath() + "/visualizzaProdottiUtente";

	String urlCreaOrdine = request.getContextPath() + "/creaOrdine";
	
	String urlPagamento = baseUrl + "/jsp/Pagamento.jsp";

	Map<Integer, String> mappaImmagini = (Map<Integer, String>) request.getSession().getAttribute("chiave_mappaImmaginiSessione");
	
	List<Prodotto> listaProdotti = (List<Prodotto>)session.getAttribute("chiave_listaProdottiCarrello");
	
	String messaggioRisultatoCreaOrdine = (String) request.getAttribute("chiave_risultatoCreaOrdine");
%>


	<h1>Riepilogo Ordine</h1>
	
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
	
	<%if(messaggioRisultatoCreaOrdine != null) {%>
		<p><%=messaggioRisultatoCreaOrdine %></p>
	<%} %>
	
	<%if(listaProdotti != null && listaProdotti.isEmpty()) {%> 	
 		<p> Nessun prodotto nel carrello </p>
	<% } else { %> 
	
<%-- 	<form id="formId" action="<%=urlPagamento%>" method="POST"> --%>
<!-- 			<input type="submit" value="Vai al pagamento"> -->
<!-- 	</form> -->
	
	<div class="container">
	<table>
		<thead>
			<tr><th>Nome</th><th>Prezzo</th><th>Immagine</th></tr>
		</thead>
		<tbody>
		<%for(Prodotto p : listaProdotti) {%>
			<%if(p.isCancellato() == false) { %>		
			<tr>
				<td><%= p.getNome()%></td><td><%= p.getPrezzo() %></td> 
				<td><img alt="" src="<%= mappaImmagini.get(p.getId()) %>" width="100" height="100" ></td>
			</tr>
			<%} %>	
		<%} %>
		</tbody>
	</table>
	</div>
		
		
	<form id="formId" action="<%=urlCreaOrdine %>" method="POST">
		<input id="confermaOrdine" type="submit" value="Conferma Ordine">
	</form>
		
	<%} %>
	
	<button id="bottonePagamento"><a href="<%=urlPagamento %>">Vai al pagamento</a></button>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../js/scriptPagamento.js"></script>
	<script src="../js/script.js"></script>
</body>
</html>