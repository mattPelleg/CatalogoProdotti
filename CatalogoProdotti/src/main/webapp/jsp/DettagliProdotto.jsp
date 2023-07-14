<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dettagli Prodotto</title>
<link rel="stylesheet" href="<%=request.getContextPath() + "/css/dettagliProdottoStyle.css" %>">
</head>
<body>
 <% 
	Prodotto prodotto =(Prodotto) request.getAttribute("dettagliProdotto");
	
	String urlUpdate= request.getContextPath()+"/modifica";
	String homepageAdminUrl = request.getContextPath() + "/visualizzaProdotti";
	
	String erroreImprevistoModificaProdotto = (String) request.getAttribute("chiave_risultatoModificaProdotto");
 %>
 
 <h1>Modifica prodotto</h1>
 
 	<div class="wrapper">
		<a  class ="button" href="<%=homepageAdminUrl %>">Torna alla home</a> &nbsp;
	</div>
 
<div class="form-box">
 <form action="<%= urlUpdate %>" method="post">
 	 <span style="color: #f08080;">Nome</span>
 	 <input type="text" name="nome" id="form" value= "<%= prodotto.getNome() %>" required> <br>
 	
 	<span style="color: #f08080;">Disponibilita</span>
 	<input type="number" id="form"name="disponibilita" value= "<%=prodotto.getDisponibilita()%>" required> <br>
  	
  	<span style="color: #f08080;">Prezzo</span>  
  	<input type="number" step="0.01" id="form" name="prezzo" value="<%=prodotto.getPrezzo()%>" required> <br>
  	
  	<input type="submit" value="Modifica" id="button">
  
  	<input type="hidden" name="id" value="<%= prodotto.getId()%>">
 </form>
 </div> 
 
<% if(erroreImprevistoModificaProdotto != null) {%>
	<p><%=erroreImprevistoModificaProdotto %></p>
<%} %>

</body>
</html>