<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
		<link rel="stylesheet" href="<%=request.getContextPath() + "/css/ordineEffettuatoStyle.css" %>">
	
</head>
<body>

<%
	String baseUrl = "http://" + request.getServerName() + ":" +
		request.getServerPort() + request.getContextPath();
	String urlHomepage = baseUrl + "/jsp/Homepage.jsp";
%>

    <div class="stripe"></div>
<div class="center">
  <div class="card">
    <div class="dismiss"></div>
    <div class="illustration">
      <div class="car">
        <div class="body">
          <div class="body-front"></div>
          <div class="body-back"></div>
          <div class="window"></div>
        </div>
        <div class="front wheel"></div>
        <div class="back wheel"></div>
      </div>
      <div class="layer-0"></div>
      <div class="layer-1">
        <div class="chunk-1">
          <div class="tree"></div>
          <div class="tree"></div>
          <div class="bush"></div>
          <div class="tree"></div>
          <div class="tree"></div>
          <div class="tree"></div>
        </div>
        <div class="chunk-2">
          <div class="tree"></div>
          <div class="tree"></div>
          <div class="tree"></div>
          <div class="bush"></div>
          <div class="tree"></div>
          <div class="tree"></div>
        </div>
      </div>
      <div class="layer-2">
        <div class="chunk-1">
          <div class="house"></div>
          <div class="house"></div>
          <div class="house"></div>
        </div>
        <div class="chunk-2">
          <div class="house"></div>
          <div class="house"></div>
          <div class="house"></div>
          <div class="house"></div>
        </div>
      </div>
      <div class="hill"></div>
    </div>
    <div class="content">
      <h2>
        Il tuo ordine è in arrivo!
      </h2>
      <p>
        Controlla la tua mail per tracciare il tuo ordine.
      </p>
      <a class="btn cart-summary--order-action" href="<%=urlHomepage %>">Torna alla home</a>
    </div>
  </div>
</div>
</body>
</html>