<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Visualizza Carrello</title>
</head>
<body>

<%
	String urlRimuovi = request.getContextPath() + "/visualizzaCarrello";
	List<Prodotto> listaProdotti = (List<Prodotto>)request.getAttribute("chiave_listaCarrello");
%>
<h1> Carrello utente </h1>
 <%if(listaProdotti != null && listaProdotti.size()==0) {%> 	
 		<p> Carrello vuoto </p>
	<% } else{ %> 
	<table border=1>
		<tr><th>Nome</th><th>Disponibiità</th><th>Prezzo</th><th>Immagine</th><th>Rimuovi dal carrello</th></tr>
		<%for(Prodotto p : listaProdotti) {%>
		<%if(p.isCancellato() == false) { %>		
		<tr><td><%= p.getNome()%></td><td><%=p.getDisponibilita() %></td><td><%= p.getPrezzo() %></td> <td></td>
			<td>
				<form action="<%= urlRimuovi %>" method="post">
				<input type="hidden" name="id" value="<%= p.getId() %>">
				<input type="submit" value="rimuovi">
				</form>
			</td>
		</tr>
		<%} %>	
	<%} %>
	</table>
<%
	}
%>

</body>
</html>


