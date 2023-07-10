<%@page import="java.util.Map"%>
<%@page import="com.azienda.catalogoProdotti.model.Prodotto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Visualizza Carrello</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="stylesheet" href="<%=request.getContextPath() + "/css/carrelloStyle.css" %>">

<style>
#summary {
	background-color: #f6f6f6;
}
body {
	background-color: seashell;
}
</style>

</head>
<body>

<%
	String baseUrl = "http://" + request.getServerName() + ":" +
		request.getServerPort() + request.getContextPath();

	String urlRimuovi = request.getContextPath() + "/rimuoviProdotto";
	String homepageNegozioUrl = request.getContextPath() + "/visualizzaProdottiUtente";
	
	String urlProcediAllOrdine = baseUrl + "/jsp/ProcediAllOrdine.jsp";
	
	List<Prodotto> listaProdotti = (List<Prodotto>)request.getAttribute("chiave_listaCarrello");
	Map<Integer, String> mappaImmagini = (Map<Integer, String>) request.getAttribute("chiave_mappaImmagini");

	request.setAttribute("chiave_listaCarrello", listaProdotti);
	String messaggioRisultatoRimuoviProdotto = (String) request.getAttribute("chiave_risultatoRisultatoRimuoviProdottoCarrello");
%>

<h1> Carrello utente </h1>

<%if(messaggioRisultatoRimuoviProdotto != null) {%>
	<p><%=messaggioRisultatoRimuoviProdotto %></p>
<%} %>

<nav>
	<a href="<%=homepageNegozioUrl %>">Torna alla home</a> &nbsp;
	<a href="<%=urlProcediAllOrdine %>">Procedi all'ordine</a> &nbsp;
</nav>

<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left" style="display:none;z-index:2;width:40%;min-width:300px;" id="mySidebar">
	<a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button">Chiudi il Menu</a>
	<a href="home2.html" onclick="w3_close()" class="w3-bar-item w3-button">Home</a>
	<a href="ordini.html" onclick="w3_close()" class="w3-bar-item w3-button">Ordini</a>
	<a href="sitoCarino.html" onclick="w3_close()" class="w3-bar-item w3-button">Logout</a>
	<a href="#ricerca-prodotto" onclick="w3_close()" class="w3-bar-item w3-button">Ricerca Prodotto</a>
	<a href="<%=homepageNegozioUrl %>" onclick="w3_close()" class="w3-bar-item w3-button">Torna alla home</a>
	<a href="<%=urlProcediAllOrdine %>" onclick="w3_close()" class="w3-bar-item w3-button">Procedi all'ordine</a>
</nav>

<div class="w3-top" style="background-color: seashell">
	<div class="w3-white w3-xlarge" style="max-width:1200px;margin:auto">
		<div class="w3-button w3-padding-16 w3-left" onclick="w3_open()">☰</div>
		<div class="w3-center w3-padding-16">Carrello</div>
	</div>
</div>


 <%if(listaProdotti != null && listaProdotti.size()==0) {%> 	
 		<p> Carrello vuoto </p>
	<% } else{ %> 
	<table border=1>
		<tr><th>Nome</th><th>Disponibiità</th><th>Prezzo</th><th>Immagine</th><th>Rimuovi dal carrello</th></tr>
		<%for(Prodotto p : listaProdotti) {%>
			<%if(p.isCancellato() == false) { %>		
			<tr><td><%= p.getNome()%></td><td><%=p.getDisponibilita() %></td><td><%= p.getPrezzo() %></td> <td><img alt="" src="<%= mappaImmagini.get(p.getId()) %>" width="100" height="100" ></td>
				<td>
					<form action="<%=urlRimuovi %>" method="POST">
						<input type="hidden" name="id" value="<%=p.getId() %>">
						<input type="submit" value="rimuovi">
					</form>
				</td>
			</tr>
			<%} %>	
		<%} %>
		</table>
	<%} %>

	<section class="order-detail row">
		<div class="order-detail--wrapper col-xs-12 col-md-12 col-lg-9">
			<header class="order-detail--head row">
				<h1 class="order-detail--title col-xs-12 col-md-12 col-lg-12">CARRELLO</h1>
				<div class="order-detail__legend row">
					<a class="order-detail__legend--action btn"
						href="@Url.ContentUrl(Model.StartPage.CheckoutPage)">Checkout</a>
					<div class="order-detail__legend--item"
						id="order-detail__legend--quantity" aria-hidden="true"
						role="presentation">Quantità</div>
					<div class="order-detail__legend--item"
						id="order-detail__legend--price" aria-hidden="true"
						role="presentation">Prezzo</div>
				</div>
			</header>
			<!-- prima immagine -->
			<%for(Prodotto p : listaProdotti) {%>

			<div class="order-detail--body row">
				<section class="cart-items col-xs-12 col-md-12 col-lg-9">
					<div class="cart-item cart-item--shopping-cart row">
						<div class="cart-item--wrapper">
							<div class="cart-item--details">
<!-- 								<a class="cart-item--link cart-item--image-link" href="@cartItem.LineItem.AddedFromUrl()"> -->
									<div class="cart-item--image">
										<img alt="" src="<%= mappaImmagini.get(p.getId()) %>" width="100" height="100">
									</div>
<!-- 								</a> -->
								<div class="cart-item--description">
									<h2 class="cart-item--title"><%= p.getNome()%></h2>
<!-- 									<div class="cart-item--action"> -->
<!-- 										<form action="/shopping-cart/removelineitem/" -->
<!-- 											data-product-id="2880123" method="post" -->
<!-- 											novalidate="novalidate"> -->
<!-- 											<input id="code" name="code" type="hidden" value="v-2880123"> -->
<!-- 											<input id="code" name="code" type="hidden" value="v-2880123"> -->
<!-- 											<button class="cart-item--submit cart-item--remove" -->
<!-- 												type="submit">Disponibilità: 4</button> -->
<!-- 										</form> -->
									</div>
								</div>
							</div>
							<div class="cart-item--values">
								<div class="cart-item--quantity">
									<form class="cart-item--quantity-form"
										action="<%=urlRimuovi %>" method="POST"
										aria-labelledby="order-detail__legend--quantity">

										<input type="hidden" name="id" value="<%=p.getId() %>">
										<input type="submit" value="rimuovi">
									</form>

								</div>
								<div class="cart-item--price"
									aria-labelledby="order-detail__legend--price">
									<span><%=p.getPrezzo() %></span>
								</div>
							</div>
						</div>
					</div>
			</div>
		</div>
	</section>
<%} %>
<!-- 	<aside class="cart-summary col-xs-12 col-md-12 col-lg-3"> -->
<!-- 		<table class="cart-summary--table"> -->
<!-- 			<thead class="cart-summary--table-head"> -->
<!-- 				<th colspan="2"> -->
<!-- 					<h2 class="cart-summary--title row">Riepilogo Ordine</h2> -->
<!-- 				</th> -->
<!-- 			</thead> -->
<!-- 			<tbody class="cart-summary--table-body"> -->
<!-- 				<tr class="cart-summary--table-row"> -->
<!-- 					<td class="cart-summary--table-col" scope="row">Articoli</td> -->
<!-- 					<td class="cart-summary--table-col">€350.00</td> -->
<!-- 				</tr> -->

<!-- 			</tbody> -->
<!-- 			<tfoot class="cart-summary--table-foot"> -->
<!-- 				<tr class="cart-summary--table-row"> -->
<!-- 					<td class="cart-summary--table-col" scope="row"> -->
<!-- 						<div>Totale</div> -->
<!-- 					</td> -->
<!-- 					<td class="cart-summary--table-col"> -->
<!-- 						<div> -->
<!-- 							<span class="cart-summary--table-total">€378.99</span> <span -->
<!-- 								class="cart-summary--table-currency">EUR</span> -->
<!-- 						</div> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 			</tfoot> -->
<!-- 		</table> -->
<!-- 		<section class="cart-summary--fields"> -->
<!-- 			<section class="cart-summary--promo-code"> -->
<!-- 				<form class="cart-summary--promo-code-form"> -->
<!-- 					<label class="cart-summary--promo-code-label" for="promocode">Codice Promozionale</label> -->
<!-- 					<div class="cart-summary--promo-code-wrapper"> -->
<!-- 						<input class="cart-summary--promo-code-input" type="text" -->
<!-- 							placeholder="Enter code" id="promocode"></input> -->
<!-- 						<button class="cart-summary--promo-code-submit btn" type="submit">Inserisci</button> -->
<!-- 					</div> -->
<!-- 				</form> -->
<!-- 			</section> -->
<!-- 			<section class="cart-summary--order-actions"> -->
<!-- 				<a class="btn cart-summary--order-action" href="pagamento.html">Checkout</a> -->
<!-- 				<a class="btn cart-summary--order-action" href="/CSS/home2.html">Continua lo shopping</a> -->
<!-- 			</section> -->
<!-- 		</section> -->
<!-- 	</aside> -->
	</div>
	</div>
	</section>

	<script>
	// Script to open and close sidebar
	function w3_open() {
	document.getElementById("mySidebar").style.display = "block";
	}
             
	function w3_close() {
	document.getElementById("mySidebar").style.display = "none";
	}
</script>

</body>
</html>


