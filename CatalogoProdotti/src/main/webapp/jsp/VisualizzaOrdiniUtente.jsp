<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="com.azienda.catalogoProdotti.model.Ordine"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Riepilogo Ordini</title>
</head>
<body>

<h1>Riepilogo Ordini</h1>

<%
	List<Ordine> listaOrdiniUtente =(List<Ordine>) request.getAttribute("chiave_risultatoGetOrdiniUtente");
%>


<%if(listaOrdiniUtente != null && listaOrdiniUtente.isEmpty()) {%> 	
 		<p> Lista ordini vuota </p>
	<% } else { %> 
	<table border=1>
		<tr><th>ID_ORDINE</th><th>DATA_ACQUISTO</th><th>NOME</th><th>PREZZO</th><th>TOT</th></tr>
		<%for(Ordine o: listaOrdiniUtente) {%>
			<%float tot = 0f; %>
			<tr><td><%=o.getId() %></td><td><%=o.getDataAcquisto() %></td>
			<%for(Prodotto p: o.getListaOrdineProdotti()) {%>
				<%tot += p.getPrezzo(); %>
				<tr><td></td><td></td><td><%=p.getNome() %></td><td><%=p.getPrezzo() %></td>
			<%} %>
				<td><%=tot %></td>
				</tr>
			</tr>
	<%} %>
	</table>
<%} %>

</body>
</html>