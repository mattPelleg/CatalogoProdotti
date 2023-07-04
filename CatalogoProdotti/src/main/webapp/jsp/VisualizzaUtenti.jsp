
<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="com.azienda.catalogoProdotti.model.Ordine"%>
<%@page import="com.azienda.catalogoProdotti.model.Utente"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lista utenti</title>
</head>
<body>
<% 
	String baseUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();

	String homePageAdmin = baseUrl + "/jsp/HomepageAdmin.jsp";
	
	String visualizzaProdottiUrl = request.getContextPath()+ "/visualizzaProdotti";
	
	List<Utente> listaUtenti = (List<Utente>) request.getAttribute("chiave_listaUtenti");
%>

<h1> Lista Utenti registrati</h1>

<a href = "<%= homePageAdmin%>"> HomePage Admin </a> &nbsp;
<a href = "<%= visualizzaProdottiUrl%>"> Visualizza Prodotti </a> &nbsp;

<%for(Utente u : listaUtenti){ %>
	<% if (u.getProfiloUtente().getNome().equals("simpleUser")) { %>
		<h4>Utente: <%=u.getEmail()%><h4>
		<table>
			<tr><th>ID_ORDINE</th><th>DATA_ACQUISTO</th><th>PRODOTTO</th><th>PREZZO</th><th>TOT</th></tr>
			<%for(Ordine o: u.getListaOrdini()) {%>
				<tr><td><%=o.getId() %></td><td><%=o.getDataAcquisto() %></td>
				<%for(Prodotto p: o.getListaOrdineProdotti()) {%>
					<tr><td></td><td></td><td><%=p.getNome() %></td><td><%=p.getPrezzo() %></td></tr>
				<%} %>
				</tr>
			<%} %>
		</table>
	<%} %>
<%} %>
</body>
</html>