<%@page import="com.azienda.catalogoProdotti.model.Utente"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Homepage Admin</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath() + "/css/homepageAdminStyle.css" %>">
<!-- <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">   -->

<style>
  body {
    margin: 0;
    padding: 0;
  }

  #mySidebar {
    background-color: #CDECEF;
  }

  .w3-top {
    background-color: #CDECEF;
  }

  .w3-center {
    background-color: #CDECEF;
  }

  .visualizza {
    background-color: #ddbea9;
    color: #f08080
  }
</style>


</head>
<body>
<%
	String baseUrl = "http://" + request.getServerName() + ":" +
	request.getServerPort() + request.getContextPath();
	String urlHomepage = baseUrl + "/jsp/Homepage.jsp";
// 	request.getServerPort() + request.getContextPath();
	
	String homepageNegozioUrl = request.getContextPath() + "/visualizzaProdottiUtente";
	String urlRicercaProdotto = baseUrl + "/jsp/RicercaProdotti.jsp";

%>
<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left" style="display:none;z-index:2;width:40%;min-width:300px;background-color:#f08080" id="mySidebar">
	<a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button">Chiudi il Menu</a>
	<a href="<%=urlHomepage%>" onclick="w3_close()" class="w3-bar-item w3-button">Home</a>
	
	<a href="<%=urlHomepage%>" onclick="w3_close()" class="w3-bar-item w3-button">Logout</a>
	<a href="<%=urlRicercaProdotto %>" onclick="w3_close()" class="w3-bar-item w3-button">Ricerca Prodotto</a>

	
</nav>

<div class="w3-top" style="background-color: #d5bdaf;">
	<div class="w3-white w3-xlarge" style="max-width:1200px;margin: left">
		<div class="w3-button w3-padding-16 w3-left" onclick="w3_open()" style= "background-color:#FFD7BA; ">☰</div>
		

	<div class="visualizza" style="background-color: #d5bdaf">
	<div class="testo">
 	<jsp:include page="/jsp/MenuAdmin.jsp"></jsp:include> 
 	</div>
	</div>
	
	</div>
	</div>
</div>
<%-- 	<jsp:include page="/jsp/Menu.jsp"></jsp:include> --%>
<%
	String uriWebapp = request.getContextPath()+ "/inserisciAdmin";
	Utente admin =(Utente) request.getSession().getAttribute("chiave_utente");
%>

	<div class="titolo">
	<h1> <strong>Marcello</strong></h1>
	</div>
	
<!-- 	<div class="visualizza"> -->
<%-- 	<jsp:include page="/jsp/MenuAdmin.jsp"></jsp:include> --%>
<!-- 	</div>  -->
	<div class="titolo">
	<h1> <strong> Pagina gestione admin </strong></h1>
	</div>
	
	<div class="benvenuto">
	<%if(admin !=null) {%>
		<h3> <em> Benvenuto <%= admin.getEmail() %> </em></h3>
	<% } %>
	</div>
	
	<div class ="admin-box">
	<h4>Inserisci Nuovo Admin</h4>
	
	<form action = "<%=uriWebapp %>" method ="POST" >
	
		<div class="user-box">
			<input type ="email" name = "emailAdminFormInput"> <br>
			<label>Email</label>
		</div>
		<div class="user-box">
			<input type ="password" name = "passwordAdminFormInput" ><br>
			<label>Password</label>
		</div>
		<!--   <input type = "submit" value = "Aggiungi">-->
		
		<a>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
			<button class="loginButton" formaction="<%=uriWebapp%>">Aggiungi</button>
          </a>

	</form>
	     <div class="inserimento">
          	<% if (request.getAttribute("chiave_adminInserito") != null) {%> 
 				<p> <%=request.getAttribute("chiave_adminInserito") %></p> 
 			<%} %>  

			<%if(request.getAttribute("chiave_errore") != null) {%> 
				<p><%=request.getAttribute("chiave_errore") %></p> 
			<% } %> 
         </div>
 </div>
	 
<%-- 	<% if (request.getAttribute("chiave_adminInserito") != null) {%> --%>
<%-- 		<p> <%=request.getAttribute("chiave_adminInserito") %></p> --%>
<%-- 	<%} %>  --%>

<%-- 	<%if(request.getAttribute("chiave_errore") != null) {%> --%>
<%-- 		<p><%=request.getAttribute("chiave_errore") %></p> --%>
<%-- 	<% } %> --%>
	


	

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