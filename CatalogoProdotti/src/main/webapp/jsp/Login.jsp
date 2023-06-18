<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Utente</title>
</head>
<body>
<jsp:include page="/jsp/Menu.jsp"></jsp:include><br>
<%
	String uriWebApp = request.getContextPath() + "/login";
%>

	<h1>Form di login</h1>
	
	<form action="<%=uriWebApp%>" method="POST">
		<input type="email" placeholder="email" name="emailFormInput"> <br>
		<input type="password" placeholder="password" name="passwordFormInput"> <br>
		<input type="submit" value="Accedi">
	</form>
	
	<%if(request.getAttribute("chiave_errore") != null) {%>
		<p><%=request.getAttribute("chiave_errore") %></p>
	<%} %>
</body>
</html>