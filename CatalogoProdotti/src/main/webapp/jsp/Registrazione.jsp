<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registrazione Nuovo Utente</title>
</head>
<body>
<jsp:include page="/jsp/Menu.jsp"></jsp:include><br>
<%
	String uriWebbApp = request.getContextPath() + "/registrazione";
%>

	<h2>Form registrazione utente</h2>
	<form action="<%=uriWebbApp %>" method="POST">
		Email: <input type="email" placeholder="email" name="emailFormInput" autofocus="autofocus"> <br>
		Password: <input type="password" placeholder="password" name="passwordFormInput"> <br>
		<input type="submit" value="Registrati">
	</form>

	<%if(request.getAttribute("chiave_errore") != null) {%>
		<p><%=request.getAttribute("chiave_errore") %></p>
	<%} %>	
</body>
</html>