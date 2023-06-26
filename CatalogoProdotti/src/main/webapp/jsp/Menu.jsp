<%
	//http:// + localhost:8080 + url
	String baseUrl = "http://" + request.getServerName() + ":" +
		request.getServerPort() + request.getContextPath();

	String registrazioneUrl = baseUrl + "/jsp/Registrazione.jsp";
	String loginUrl = baseUrl + "/jsp/Login.jsp";
	String homePageUrl = baseUrl + "/jsp/Homepage.jsp";
	//AGGIUNGERE COLLEGAMENTO PRODOTTI
	String prodottiUrl = baseUrl + "/jsp/ElencoProdotti.jsp";
	String logoutUrl = baseUrl + "/jsp/Homepage.jsp";
%>
<nav>
	<a href="<%=homePageUrl%>">Home</a> &nbsp;
	<a href="<%=prodottiUrl%>">Prodotti</a> &nbsp;
	<a href="<%=registrazioneUrl%>">Registrati</a> &nbsp;
	<a href="<%=loginUrl%>">Login</a> &nbsp;
<%-- 	<a href="<%=logoutUrl%>">Logout</a> &nbsp; --%>
</nav>