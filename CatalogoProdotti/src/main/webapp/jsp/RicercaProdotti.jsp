<%@page import="java.util.Map"%>
<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ricerca Prodotti</title>
<link rel="stylesheet" href="<%=request.getContextPath() + "/css/RicercaProdottiStyle.css" %>">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
</head>
<body>
<% 
	String baseUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
	String homePageAdmin = baseUrl + "/jsp/HomepageAdmin.jsp";
	
	String visualizzaUtentiUrl = request.getContextPath()+ "/visualizzaUtenti";
	String homepageAdminUrl = request.getContextPath() + "/visualizzaProdotti";
	String urlModifica = request.getContextPath() + "/goToModifica";
	String urlCancella = request.getContextPath() + "/delete";		
	String webApp = request.getContextPath();
	String formAction = webApp + "/ricerca";
	
	List<Prodotto> listaProdotti = (List<Prodotto>) request.getAttribute("chiave_ricerca");
	Map <Integer, String> mappaImmagini = (Map <Integer, String>) request.getAttribute("chiave_mappaImmagini");

		
%>

<h1>Form di ricerca prodotti</h1>

	<div class="wrapper">
		<a  class ="button" href="<%=homepageAdminUrl %>">Torna alla home</a> &nbsp;
	</div>
	<svg style="visibility: hidden; position: absolute;" width="0" height="0" xmlns="http://www.w3.org/2000/svg" version="1.1">
    <defs>
        <filter id="goo"><feGaussianBlur in="SourceGraphic" stdDeviation="10" result="blur" />    
            <feColorMatrix in="blur" mode="matrix" values="1 0 0 0 0  0 1 0 0 0  0 0 1 0 0  0 0 0 19 -9" result="goo" />
            <feComposite in="SourceGraphic" in2="goo" operator="atop"/>
        </filter>
    </defs>
</svg>

 
 <div id="cover">
 <form action="<%= formAction %>" method="post"> 
     <input type="text" id="form" placeholder="Nome" name="nome">
       <input type="number" step= "0.01" id="form" placeholder="Prezzo" name="prezzo">
      <input type="submit" id="button" value="Enter">
      </form>
</div>


 <h3><b> Risultato Ricerca </b></h3>
<%if(listaProdotti != null && !listaProdotti.isEmpty()) {%> 	
<div class="container">
	<table border=1>
	<tr><th>Nome</th><th>Disponibiità</th><th>Prezzo</th><th>Immagine</th><th>Modifica</th><th>Cancella</th></tr>
	<%for(Prodotto p : listaProdotti) {%>
		<%if(p.isCancellato() == false) { %>		
			<tr><td><%= p.getNome()%></td><td><%=p.getDisponibilita() %></td><td><%= p.getPrezzo() %> €</td> 
			<td><img alt="" src="<%= mappaImmagini.get(p.getId()) %>" width="100" height="100" ></td>
			<td>
				<form action="<%= urlModifica %>" method="post">
					<input type="hidden" name="id" value="<%= p.getId() %>">
					<input type="submit" value="modifica">
				</form>
			</td>
			
			<td>
				<form action="<%= urlCancella %>" method="post">
					<input type="hidden" name="id" value="<%= p.getId() %>">
					<input type="submit" value="cancella">
				</form>
			</td>
		</tr>
		<%} %>	
	<%} %>
	</table>
</div>
<%} else {%>
	<p>Lista vuota, effettua una ricerca</p>
<%} %>


<%if(request.getAttribute("chiave_messaggio") != null) {%>
	<%=request.getAttribute("chiave_messaggio") %>
<%} %>
</body>
</html>