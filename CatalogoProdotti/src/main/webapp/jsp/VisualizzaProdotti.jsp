<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestione Prodotti</title>
</head>
<body>

<% 
	String baseUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	String homePageAdmin = baseUrl + "/jsp/HomepageAdmin.jsp";
	String visualizzaUtentiUrl = request.getContextPath()+ "/visualizzaUtenti";
	String ricercaProdottiUrl = baseUrl + "/jsp/RicercaProdotti.jsp";
		
	String urlModifica = request.getContextPath() + "/goToModifica";
	String urlCancella = request.getContextPath() + "/delete";		
	String urlCreaProdotto = request.getContextPath() + "/creaProdotto";	
	List<Prodotto> listaProdotti = (List<Prodotto>)request.getAttribute("chiave_listaProdotti");
	
	String messaggioRisultatoModificaProdotto = (String) request.getAttribute("chiave_modificaProdotto");
	String messaggioRisultatoInserisciProdotto = (String) request.getAttribute("chiave_erroreInserisciProdotto");
	
%>
	<h1>Pagina gestione prodotti</h1>
	<a href="<%= homePageAdmin%>"> HomePage Admin </a> &nbsp; &nbsp;
	<a href="<%= visualizzaUtentiUrl%>"> Visualizza utenti </a> &nbsp; &nbsp;
	<a href="<%= ricercaProdottiUrl%>"> Ricerca prodotti</a>
	
	<h3>Form inserisci prodotto</h3>
	<form action="<%= urlCreaProdotto %>"method="post">
		nome <input type="text" name="nomeFormInput" required>  <br>
		disponibilità <input type= "number" name= "disponibilitaFormInput" required> <br>
		prezzo <input type= "number" step="0.01" name= "prezzoFormInput" required> <br>
		
		<input type="submit" value="Salva">
	</form>
	<br><br>
	
	<!-- 	stampa un messaggio quando si modifica un prodotto -->
	<%if(messaggioRisultatoModificaProdotto != null) {%>
		<p> <%= messaggioRisultatoModificaProdotto%></p>
	<%} %>
	<!-- 	stampa un messaggio quando si aggiunge un prodotto  -->
	<%if(messaggioRisultatoInserisciProdotto != null) {%>
		 <p> <%= messaggioRisultatoInserisciProdotto%></p>
	<%} %>
	
	<%if(listaProdotti.size()==0) {%> 	
 		<p> Lista prodotti vuota </p>
	<% } else{ %> 
	<table border=1>
		<tr><th>Nome</th><th>Disponibiità</th><th>Prezzo</th><th>Immagine</th><th>Modifica</th><th>Cancella</th></tr>
		<%for(Prodotto p : listaProdotti) {%>
		<%if(p.isCancellato() == false) { %>		
		<tr><td><%= p.getNome()%></td><td><%=p.getDisponibilita() %></td><td><%= p.getPrezzo() %></td> <td></td>
			<td>
				<form action="<%= urlModifica %>" method="post">
				<input type="hidden" name="id" value="<%= p.getId() %>">
				<input type="submit" value="modifica">
				</form>
			</td>
			
			<td>
				<form action="<%= urlCancella %>" method="post">
				<input type="hidden" name="id" value="<%= p.getId() %>">
				<input type="submit" value="cancella">
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