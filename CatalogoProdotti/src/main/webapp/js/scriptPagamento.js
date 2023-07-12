function mostraBottone() {
  var bottone = document.getElementById("bottonePagamento");
  bottone.style.display = "block";
}

document.addEventListener("DOMContentLoaded", function() {
  var form = document.getElementById("formId");
  var tastoInvia = document.getElementById("confermaOrdine");
  var bottone = document.getElementById("bottonePagamento");

  form.addEventListener("submit", function(event) {
//    event.preventDefault();
    mostraBottone();
  });

  tastoInvia.addEventListener("click", function() {
    mostraBottone();
  });

  bottone.style.display = "none";
});