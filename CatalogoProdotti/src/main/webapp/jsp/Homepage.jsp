<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Homepage Catalogo Prodotti</title>


<link rel="stylesheet" href="<%=request.getContextPath() + "/css/homepageStyle.css" %>">
<style>
body {
	background-image: url("<%=request.getContextPath() + "/static/immagineSfondoHomepage.jpg"%>");
	background-size: cover;
}
</style>

</head>
<body>
<!-- 	<h1>Mayone & Mayoni</h1> -->
	
<!-- 	<div> -->
<%-- 		<jsp:include page="/jsp/Menu.jsp"></jsp:include>	 --%>
<!-- 	</div> -->
	
	<div class="immagineLogo">
    <img src="<%=request.getContextPath() + "/static/immagineLogo.jpg"%>" alt= "Immagine logo" class="round-image" width="200px" height="200px">
    </div>
    <div class="titolo">
        <h1 class="Mayone">Mayone e Mayoni</h1>
    </div>

    <div class="button-container">
        <div id="workarea">
            <div class="position">
          
              <!--start button, nothing above this is necessary -->
              <div class="svg-wrapper">
                <svg height="40" width="150" xmlns="http://www.w3.org/2000/svg">
                  <rect id="shape" height="40" width="150" />
                  <div id="text">
                    <a href="../jsp/Login.jsp"><span class="spot"></span>Login</a>
                  </div>
                </svg>
              </div>
              
              <!--Next button -->
              <div class="svg-wrapper">
                <svg height="40" width="150" xmlns="http://www.w3.org/2000/svg">
                  <rect id="shape" height="40" width="150" />
                  <div id="text">
                    <a href="../jsp/Registrazione.jsp"><span class="spot"></span>Registrati</a>
                  </div>
                </svg>
              </div>

      </div>


</body>
</html>