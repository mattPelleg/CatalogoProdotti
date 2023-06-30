<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Homepage Catalogo Prodotti</title>
<link rel="stylesheet" href="../css/style.css">

</head>
<body>
	<h1>Mayone & Mayoni</h1>
	
<!-- 	<img alt="cime_di_lavaredo" src="../static/tre_cime_lavaredo.jpg"> -->

	<div>
		<jsp:include page="/jsp/Menu.jsp"></jsp:include>	
	</div>
	
	<%if(request.getAttribute("chiave_risultatoSessione") != null) {%>
		<p><%=request.getAttribute("chiave_risultatoSessione") %></p>
	<%} %>

</body>
</html>