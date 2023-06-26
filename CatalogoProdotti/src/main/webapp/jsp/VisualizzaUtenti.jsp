
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
		<p> <%=u.getEmail() %></p>
	<%} %>
<%} %>
</body>
</html>