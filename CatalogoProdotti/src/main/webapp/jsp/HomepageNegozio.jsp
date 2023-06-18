<%@page import="com.azienda.catalogoProdotti.model.Utente"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Homepage Negozio</title>
</head>
<body>
<jsp:include page="/jsp/Menu.jsp"></jsp:include><br>
<%
	Utente utenteLoggato = (Utente)request.getAttribute("chiave_utente");
%>

	<h1>Mayone & Mayoni</h1>
	
	<h3>Ciao <%=utenteLoggato.getEmail() %></h3>
</body>
</html>