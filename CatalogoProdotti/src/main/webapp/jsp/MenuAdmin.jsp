<%
	//http:// + localhost:8080 + url
	String baseUrl = "http://" + request.getServerName() + ":" +
		request.getServerPort() + request.getContextPath();

	String registrazioneUrl = baseUrl + "/jsp/Registrazione.jsp";
	String loginUrl = baseUrl + "/jsp/Login.jsp";
	String homePageUrl = baseUrl + "/jsp/Homepage.jsp";
	String visualizzaUtentiUrl = request.getContextPath()+ "/visualizzaUtenti";
	String visualizzaProdottiUrl = request.getContextPath()+ "/visualizzaProdotti";
	//AGGIUNGERE COLLEGAMENTO PRODOTTI
	String prodottiUrl = baseUrl + "/jsp/ElencoProdotti.jsp";
	String logoutUrl = baseUrl + "/jsp/Homepage.jsp";
%>

<nav>
	<a href="<%=registrazioneUrl%>">Registrati</a> &nbsp;
	<a href="<%=loginUrl%>">Login</a> &nbsp;
	<a href="<%=homePageUrl%>">Home</a> &nbsp;
	<a href="<%=prodottiUrl%>">Prodotti</a> &nbsp;
	<a href = "<%= visualizzaUtentiUrl%>"> Visualizza utenti </a> &nbsp;
	<a href = "<%= visualizzaProdottiUrl%>"> Visualizza Prodotti </a> &nbsp;
	<a href="<%=logoutUrl%>">Logout</a> &nbsp;
</nav>