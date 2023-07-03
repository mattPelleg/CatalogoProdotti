<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Registrazione Nuovo Utente</title>
<link rel="stylesheet" href="../css/registrazioneStyle.css">

</head>
<body>
<%-- <jsp:include page="/jsp/Menu.jsp"></jsp:include><br> --%>
<%
	String uriWebbApp = request.getContextPath() + "/registrazione";
%>

<div class="immagineLogo">
    <img src="../static/immagineLogo.jpg" alt= "Immagine logo" class="round-image" width="200px" height="200px">
    </div>
    <div class="login-box">
        <h2>Registrazione</h2>
        <form action="<%=uriWebbApp %>" method="POST">
          <div class="user-box">
            <input type="email" name="emailFormInput" required="" autofocus="autofocus">
            <label>Email</label>
          </div>
          <div class="user-box">
            <input type="password" name="passwordFormInput" required="">
            <label>Password</label>
          </div>
<!--           <input type="submit" value="Registrati"> -->
          
          <a href="#">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
			<button class="loginButton" formaction="<%=uriWebbApp%>">Registrati</button>
            
<!--             Registrati -->
          </a>
        </form>
      </div>

<!-- 	<h2>Form registrazione utente</h2> -->
<%-- 	<form action="<%=uriWebbApp %>" method="POST"> --%>
<!-- 		Email: <input type="email" placeholder="email" name="emailFormInput" autofocus="autofocus"> <br> -->
<!-- 		Password: <input type="password" placeholder="password" name="passwordFormInput"> <br> -->
<!-- 		<input type="submit" value="Registrati"> -->
<!-- 	</form> -->

	<%if(request.getAttribute("chiave_errore") != null) {%>
		<p><%=request.getAttribute("chiave_errore") %></p>
	<%} %>	
</body>
</html>