<%
	String urlBase = "http://" + request.getServerName() + ":" +
		request.getServerPort() + request.getContextPath();

	String homepageUrl = urlBase + "/jsp/Homepage.jsp"; 
%>
	 <a href ="<%=homepageUrl%>"><button>Torna alla home </button></a> &nbsp;