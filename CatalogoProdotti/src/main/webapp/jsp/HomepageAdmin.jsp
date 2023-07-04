<%@page import="com.azienda.catalogoProdotti.model.Utente"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Homepage Admin</title>
</head>
<body>
	<jsp:include page="/jsp/Menu.jsp"></jsp:include>
<%
	String uriWebapp = request.getContextPath()+ "/inserisciAdmin";
// 	Utente admin =(Utente) request.getAttribute("chiave_admin");
	Utente admin =(Utente) request.getSession().getAttribute("chiave_utente");
%>
	<h1> Pagina gestione admin </h1>
	<jsp:include page="/jsp/MenuAdmin.jsp"></jsp:include>

	<%if(admin !=null) {%>
		<h3> Benvenuto <%= admin.getEmail() %></h3>
	<% } %>
	<h4>Form inserisci Admin</h4>
	<form action = "<%=uriWebapp %>" method ="POST" >
		<input type ="email" placeholder ="email" name = "emailAdminFormInput"> <br>
		<input type ="password" placeholder ="password" name = "passwordAdminFormInput"><br>

		<input type = "submit" value = "Aggiungi">

	</form>
	 
	<% if (request.getAttribute("chiave_adminInserito") != null) {%>
		<p> <%=request.getAttribute("chiave_adminInserito") %></p>
	<%} %> 

	<%if(request.getAttribute("chiave_errore") != null) {%>
		<p><%=request.getAttribute("chiave_errore") %></p>
	<% } %>
	

	<br> 
	<br>
	

</body>
</html>