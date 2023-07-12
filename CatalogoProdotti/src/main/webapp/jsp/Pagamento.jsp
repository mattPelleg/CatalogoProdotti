<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
	<link rel="stylesheet" href="<%=request.getContextPath() + "/css/pagamentoStyle.css" %>">
	
</head>
<body>

<%
	String baseUrl = "http://" + request.getServerName() + ":" +
		request.getServerPort() + request.getContextPath();
	String urlOrdineEffettuato = baseUrl + "/jsp/OrdineEffettuato.jsp";

%>
    <div class="wrapper">
        <div class="card">  
          <h2 class="visa">VISA</h2>
          <h3 class="num">nÂ° 4539  7111  0342  0778</h3>
      
            <h4>Name</br>Rossi</h4>
            <h4>EXP</br>10/21</h4>
            <h4>CVC</br>014</h4>
      
        </div>
        <div class="main">
          <div class="content">
            <h1>Dettagli del pagamento</h1>
            <form>
              
           <!--   <label>Name</label>-->
              <input id="name" type="name" value="Rossi">
              
             <!-- <label>Card Number</label>-->
              <input type="text" value="4539 7111 0342 0778">
              
            <!--  <label>Expiration Date</label>-->
              <input type="month" value="2021-10">
              <input type="user" value="014">
              
            </form>
            <div class="payment">
              <h4>Totale da pagare<div class ="amount"> 50€</div></h4> 
              
<!--               <a class="payment" href="ordineEffettuato.html"> -->
<!--                 <button>Paga Ora</button> -->
                <form class="payment" action="<%=urlOrdineEffettuato %>" method="POST">
                	<input type="submit" value="Paga Ora">
                </form>

              </div>
          </div>
        </div>
      </div>
   
</body>
</html>