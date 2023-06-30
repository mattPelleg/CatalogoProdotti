<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String homepageNegozioUrl = request.getContextPath() + "/visualizzaProdottiUtente";
	String urlAggiungiAlCarrello = request.getContextPath() + "/aggiungiAlCarrello";
	String formAction = request.getContextPath() + "/ricerca";

	List<Prodotto> listaProdotti = (List<Prodotto>) request.getAttribute("chiave_ricerca");
%>

	<h1>Ricerca Prodotti</h1>

	<nav>
		<a href="<%=homepageNegozioUrl %>">Torna alla home</a> &nbsp;
	</nav>
	
	<form action="<%=formAction %>" method="post">
  		nome: <input type="text" name="nome"> <br>
  		prezzo: <input type="number" step="0.01" name="prezzo"> <br>
  	<input type="submit" value="Cerca">
 
 </form>
	
	 <h3>Risultato Ricerca</h3>
	<%if(listaProdotti != null && !listaProdotti.isEmpty()) {%> 	
	<table border=1>
	<tr><th>Nome</th><th>Disponibiità</th><th>Prezzo</th><th>Immagine</th><th>Aggiungi al Carrello</th></tr>
	<%for(Prodotto p : listaProdotti) {%>
		<%if(p.isCancellato() == false && p.getDisponibilita() > 0) { %>		
			<tr><td><%= p.getNome()%></td><td><%=p.getDisponibilita() %></td><td><%= p.getPrezzo() %></td> <td></td>
			<td>
				<form action="<%=urlAggiungiAlCarrello %>" method="post">
					<input type="hidden" name="id" value="<%= p.getId() %>">
					<input type="submit" value="Aggiungi">
				</form>
			</td>
		</tr>
		<%} %>	
	<%} %>
	</table>
<%} else {%>
	<p>Lista vuota, effettua una ricerca</p>
<%} %>

<%if(request.getAttribute("chiave_messaggio") != null) {%>
	<%=request.getAttribute("chiave_messaggio") %>
<%} %>
</body>
</html>