<%@page import="java.util.Map"%>
<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ricerca Prodotti</title>

</head>
<body>
<% 
	String baseUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	String homePageAdmin = baseUrl + "/jsp/HomepageAdmin.jsp";
	
	String visualizzaUtentiUrl = request.getContextPath()+ "/visualizzaUtenti";
	String homepageAdminUrl = request.getContextPath() + "/visualizzaProdotti";
	String urlModifica = request.getContextPath() + "/goToModifica";
	String urlCancella = request.getContextPath() + "/delete";		
	String webApp = request.getContextPath();
	String formAction = webApp + "/ricerca";
	
	List<Prodotto> listaProdotti = (List<Prodotto>) request.getAttribute("chiave_ricerca");
	Map <Integer, String> mappaImmagini = (Map <Integer, String>) request.getAttribute("chiave_mappaImmagini");

		
%>
<h1>Form di ricerca prodotti</h1>

	<nav>
		<a href="<%=homepageAdminUrl %>">Torna alla home</a> &nbsp;
	</nav>

<form action="<%= formAction %>" method="post">
  	nome: <input type="text" name="nome"> <br>
  	prezzo: <input type="number" step="0.01" name="prezzo"> <br>
  	<input type="submit" value="Cerca">
 
 </form>
 
 <h3>Risultato Ricerca</h3>
<%if(listaProdotti != null && !listaProdotti.isEmpty()) {%> 	
	<table border=1>
	<tr><th>Nome</th><th>DisponibiitÓ</th><th>Prezzo</th><th>Immagine</th><th>Modifica</th><th>Cancella</th></tr>
	<%for(Prodotto p : listaProdotti) {%>
		<%if(p.isCancellato() == false) { %>		
			<tr><td><%= p.getNome()%></td><td><%=p.getDisponibilita() %></td><td><%= p.getPrezzo() %></td> 
			<td><img alt="" src="<%= mappaImmagini.get(p.getId()) %>" width="100" height="100" ></td>
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
<%} else {%>
	<p>Lista vuota, effettua una ricerca</p>
<%} %>


<%if(request.getAttribute("chiave_messaggio") != null) {%>
	<%=request.getAttribute("chiave_messaggio") %>
<%} %>
</body>
</html>