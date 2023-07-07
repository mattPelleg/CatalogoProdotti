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

<link rel="stylesheet"  href="<%=request.getContextPath() + "/css/visualizzaOrdiniAdminStyle.css" %>"">
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
	<div class="navbar">
		<nav>
			<a href="<%=homepageAdmin %>">Torna alla home</a>
		</nav>
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
				<tr><td></td><td></td><td></td><td></td><td><%=p.getNome() %></td><td><%=p.getPrezzo() %></td>
			<%} %>
<%-- 				<td><%=tot %></td> --%>
				</tr>
				<tr><td>TOT</td><td></td><td></td><td></td><td></td><td><%=tot %></td></tr>
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