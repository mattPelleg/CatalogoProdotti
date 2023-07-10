<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Registrazione Nuovo Utente</title>


<link rel="stylesheet" href="<%=request.getContextPath() + "/css/loginStyle.css" %>">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">  
<style>
  body {
    margin: 0;
    padding: 0;
  }

  #mySidebar {
    background-color: #D3DDEA;
  }

  .w3-top {
    background-color: #D3DDEA;
  }

  .w3-center {
    background-color: #D3DDEA;
  }

  .visualizza {
    background-color: #D3DDEA;
  }
</style>
</head>
<body>
<%
	String baseUrl = "http://" + request.getServerName() + ":" +
	request.getServerPort() + request.getContextPath();
	String uriWebApp = request.getContextPath() + "/login";

	String urlHomepage = baseUrl + "/jsp/Homepage.jsp";
	//	request.getServerPort() + request.getContextPath();
	String urlLogin = baseUrl + "/jsp/Login.jsp";
%>
<%-- <jsp:include page="/jsp/Menu.jsp"></jsp:include><br> --%>

<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left" style="display:none;z-index:2;width:40%;min-width:300px;background-color:#2B91AD; color:#F2F7F9" id="mySidebar">
	<a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button">Chiudi il Menu</a>
	<a href="<%=urlHomepage%>" onclick="w3_close()" class="w3-bar-item w3-button">Home</a>
	<a href="<%=urlLogin%>" onclick="w3_close()" class="w3-bar-item w3-button">Login</a>
	
</nav>

<!-- <div class="w3-top" style="color: #D3DDEA"> -->
	<div class="w3-white w3-xlarge" style="max-width:1200px; margin: left">
		<span class="w3-button w3-padding-16 w3-left" onclick="w3_open()" style= "background-color:#2B91AD; ">☰</span>
<!-- 		<div class="w3-center w3-padding-16" style="backbground-color: #CDECEF"> -->
	
		</div>
		</div>
<%-- <jsp:include page="/jsp/Menu.jsp"></jsp:include><br> --%>
<%
	String uriWebbApp = request.getContextPath() + "/registrazione";
%>

<div class="immagineLogo">
    <img src="<%=request.getContextPath() + "/static/immagineLogo.jpg" %>" alt= "Immagine logo" class="round-image" width="200px" height="200px">
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
          
          <a>
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
	<script>
	// Script to open and close sidebar
	function w3_open() {
	document.getElementById("mySidebar").style.display = "block";
	}
             
	function w3_close() {
	document.getElementById("mySidebar").style.display = "none";
	}
	</script>
</body>
</html>