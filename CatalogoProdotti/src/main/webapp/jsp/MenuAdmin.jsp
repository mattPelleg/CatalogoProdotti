<%
	//http:// + localhost:8080 + url
	String baseUrl = "http://" + request.getServerName() + ":" +
		request.getServerPort() + request.getContextPath();

	String visualizzaUtentiUrl = request.getContextPath()+ "/visualizzaUtenti";
	String visualizzaProdottiUrl = request.getContextPath()+ "/visualizzaProdotti";
	String visualizzaOrdiniAdminUrl = request.getContextPath()+ "/visualizzaOrdiniAdmin";
%>

<nav>
	<a href = "<%=visualizzaUtentiUrl%>"> Visualizza Utenti </a> &nbsp;
	<a href = "<%=visualizzaProdottiUrl%>"> Visualizza Prodotti </a> &nbsp;
	<a href = "<%=visualizzaOrdiniAdminUrl%>"> Visualizza Ordini Utenti </a> &nbsp;
</nav>