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
  String urlUpdate= request.getContextPath()+"/modifica";
  Prodotto prodotto =(Prodotto) request.getAttribute("dettagliProdotto");
 %>
 
 <form action="<%= urlUpdate %>" method="post">
  nome <input type="text" name="name" value= "<%= prodotto.getNome() %>"> <br>
  disponibilita <input type="number" name="disponibilita" value= "<%=prodotto.getDisponibilita()%>"> <br>
  prezzo <input type="number" step="0.01" name="prezzo" value="<%=prodotto.getPrezzo()%>"> <br>
  <input type="submit" value="Modifica">
  
  <input type="hidden" name="id" value="<%= prodotto.getId()%>">
 
 </form>

</body>
</html>