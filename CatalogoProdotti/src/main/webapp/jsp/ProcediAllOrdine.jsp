<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ordine</title>
</head>
<body>

<%
	List<Prodotto> listaProdotti = (List<Prodotto>)session.getAttribute("chiave_listaProdottiCarrello");
%>


	<h1>Riepilogo Ordine</h1>
	
	<%if(listaProdotti != null && listaProdotti.size()==0) {%> 	
 		<p> Nessun prodotto nel carrello </p>
	<% } else{ %> 
	<table border=1>
		<tr><th>Nome</th><th>Disponibilità</th><th>Prezzo</th><th>Immagine</th></tr>
		<%for(Prodotto p : listaProdotti) {%>
			<%if(p.isCancellato() == false) { %>		
			<tr><td><%= p.getNome()%></td><td><%=p.getDisponibilita() %></td><td><%= p.getPrezzo() %></td> <td></td>
<!-- 				<td> -->
<%-- 					<form action="<%= urlRimuovi %>" method="post"> --%>
<%-- 						<input type="hidden" name="id" value="<%= p.getId() %>"> --%>
<!-- 						<input type="submit" value="rimuovi"> -->
<!-- 					</form> -->
<!-- 				</td> -->
			</tr>
			<%} %>	
		<%} %>
		</table>
	<%} %>
</body>
</html>