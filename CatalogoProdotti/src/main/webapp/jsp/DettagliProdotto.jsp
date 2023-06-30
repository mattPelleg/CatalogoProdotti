<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dettagli Prodotto</title>
</head>
<body>
 <% 
	Prodotto prodotto =(Prodotto) request.getAttribute("dettagliProdotto");
	
	String urlUpdate= request.getContextPath()+"/modifica";
	String homepageAdminUrl = request.getContextPath() + "/visualizzaProdotti";
	
	String erroreImprevistoModificaProdotto = (String) request.getAttribute("chiave_risultatoModificaProdotto");
 %>
 
 <h1>Modifica prodotto</h1>
 
 	<nav>
		<a href="<%=homepageAdminUrl %>">Torna alla home</a> &nbsp;
	</nav>
 
 <form action="<%= urlUpdate %>" method="post">
 	 nome <input type="text" name="nome" value= "<%= prodotto.getNome() %>" required> <br>
 	disponibilita <input type="number" name="disponibilita" value= "<%=prodotto.getDisponibilita()%>" required> <br>
  	prezzo <input type="number" step="0.01" name="prezzo" value="<%=prodotto.getPrezzo()%>" required> <br>
  	<input type="submit" value="Modifica">
  
  	<input type="hidden" name="id" value="<%= prodotto.getId()%>">
 </form>

<% if(erroreImprevistoModificaProdotto != null) {%>
	<p><%=erroreImprevistoModificaProdotto %></p>
<%} %>

</body>
</html>