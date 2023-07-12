
<%@page import="com.azienda.catalogoProdotti.model.Utente"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lista utenti</title>
<link rel="stylesheet" href="<%=request.getContextPath() + "/css/visualizzaUtenti.css" %>">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> 

</head>
<body>
<% 
	String baseUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();

	String homePageAdmin = baseUrl + "/jsp/HomepageAdmin.jsp";
	
	String visualizzaProdottiUrl = request.getContextPath()+ "/visualizzaProdotti";
	String urlHomepage = baseUrl + "/jsp/Homepage.jsp";
// 	request.getServerPort() + request.getContextPath();
	
	String homepageNegozioUrl = request.getContextPath() + "/visualizzaProdottiUtente";
	String urlRicercaProdotto = baseUrl + "/jsp/RicercaProdotti.jsp";
	List<Utente> listaUtenti = (List<Utente>) request.getAttribute("chiave_listaUtenti");
%>
<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left" style="display:none;z-index:2;width:40%;min-width:300px;background-color: #DC143C;" id="mySidebar">
	<a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button">Chiudi il Menu</a>
	<a href="<%=urlHomepage%>" onclick="w3_close()" class="w3-bar-item w3-button">Home</a>
	
	<a href="<%=urlHomepage%>" onclick="w3_close()" class="w3-bar-item w3-button">Logout</a>
	<a href="<%=urlRicercaProdotto %>" onclick="w3_close()" class="w3-bar-item w3-button">Ricerca Prodotto</a>

	
</nav>

<div class="w3-top">
	<div class="w3-white w3-xlarge" style="max-width:1200px;margin: left">
		<div class="w3-button w3-padding-16 w3-left" onclick="w3_open()" style= "background-color:#F2F7F9; ">☰</div>
		<div class="w3-center w3-padding-16" style="backbground-color: #F2F7F9">

		<div class="visualizza" style="background-color: #F2F7F9">
		 		<a href = "<%= homePageAdmin%>"> HomePage Admin </a> &nbsp;
		        <a href = "<%= visualizzaProdottiUrl%>"> Visualizza Prodotti </a> &nbsp;
		</div>
	
	</div>
	</div>
</div>
<br> <br>
<h1> Lista Utenti registrati</h1>


<%-- <a href = "<%= homePageAdmin%>"> HomePage Admin </a> &nbsp; --%>
<%-- <a href = "<%= visualizzaProdottiUrl%>"> Visualizza Prodotti </a> &nbsp; --%>
<div class ="lista">
<%for(Utente u : listaUtenti){ %>
	<% if (u.getProfiloUtente().getNome().equals("simpleUser")) { %>
		<ul><li><p> <%=u.getEmail()%></p></li></ul>
	<%} %>
<%} %>
</div>
	<script>
	// Script to open and close sidebar
	function w3_open() {
	document.getElementById("mySidebar").style.display = "block";
	}
             
	function w3_close() {
	document.getElementById("mySidebar").style.display = "none";
	}
</script>
<!-- DECORAZIONE -->
 <div class="wrapper">
  <div class="ball"></div>
  <div class="ball"></div>
  <div class="ball"></div>
</div>

<svg>
  <defs>
    <filter id="filter">
      <feGaussianBlur in="SourceGraphic" stdDeviation="18" result="blur" />
      <feColorMatrix in="blur" mode="matrix" values="1 0 0 0 0  0 1 0 0 0  0 0 1 0 0  0 0 0 28 -10" result="filter" />
      <feComposite in="SourceGraphic" in2="filter" operator="atop" />
    </filter>
  </defs>
</svg>

</body>
</html>