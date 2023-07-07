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
<link rel="stylesheet" href="<%=request.getContextPath() + "/css/visualizzaOrdiniAdminStyle.css" %>">

</head>
<body>


<%
	String homepageNegozioUrl = request.getContextPath() + "/visualizzaProdottiUtente";
	Map <Integer, String> mappaImmagini = (Map <Integer, String>) request.getAttribute("chiave_mappaImmagini");

	List<Ordine> listaOrdiniUtente =(List<Ordine>) request.getAttribute("chiave_risultatoGetOrdiniUtente");
%>

<h1>Riepilogo Ordini</h1>

	<nav>
		<a href="<%=homepageNegozioUrl %>">Torna alla home</a> &nbsp;
	</nav>


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
			<tr><td><%=o.getId() %></td><td><%=o.getDataAcquisto() %></td>
			<%for(Prodotto p: o.getListaOrdineProdotti()) {%>
				<%tot += p.getPrezzo(); %>
				<tr><td></td><td></td><td><%=p.getNome() %></td><td><%=p.getPrezzo() %></td>
				<td><img alt="" src="<%= mappaImmagini.get(p.getId()) %>" width="100" height="100" ></td>
			<%} %>
				<td><%=tot %></td>
				</tr>
			</tr>
		<%} %>
		</tbody>
	</table>
<%} %>
</div>

</body>
</html>