<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Login Utente</title>

<link rel="stylesheet" href="<%=request.getContextPath() + "/css/loginStyle.css" %>">

</head>
<body>
<%
	String uriWebApp = request.getContextPath() + "/login";
%>
<jsp:include page="/jsp/Menu.jsp"></jsp:include><br>

<!-- 	<h1>Form di login</h1> -->
	
<%-- 	<form action="<%=uriWebApp%>" method="POST"> --%>
<!-- 		<input type="email" placeholder="email" name="emailFormInput" autofocus="autofocus"> <br> -->
<!-- 		<input type="password" placeholder="password" name="passwordFormInput"> <br> -->
<!-- 		<input type="submit" value="Accedi"> -->
<!-- 	</form> -->
	
	<div class="immagineLogo">
    <img src="<%=request.getContextPath() + "/static/immagineLogo.jpg" %>" alt= "Immagine logo" class="round-image" width="200px" height="200px">
    </div>
    <div class="login-box">
        <h2>Login</h2>
        <form action="<%=uriWebApp%>" method="POST">
          <div class="user-box">
            <input type="email" name="emailFormInput" required="" autofocus="autofocus">
            <label>Email</label>
          </div>
          <div class="user-box">
            <input type="password" name="passwordFormInput" required="">
            <label>Password</label>
          </div>
<!--           <input type="submit" value="Accedi"> -->
          <a>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
<!--             Accedi -->
			<button class="loginButton" formaction="<%=uriWebApp%>">Accedi</button>
          </a>
        </form>
      </div>
	
	
	<%if(request.getAttribute("chiave_errore") != null) {%>
		<p><%=request.getAttribute("chiave_errore") %></p>
	<%} %>
</body>
</html>