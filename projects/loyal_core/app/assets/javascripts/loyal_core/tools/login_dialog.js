var loyalLoginDialog = (function(mod){
  // public
  mod.onload = function(){
    var currentUrl = window.location.href;
    var encodeCurrentURL = encodeURIComponent(currentUrl);

    var winHTML = "<div id='passport-login-window'>" +
     "<form>" +
     "<div>" +
     "</div>" +
     "</form>" +
     "</div>";

  }

  return mod;
})(window.loyalLoginDialog || {});

$(function(){
  loyalLoginDialog.onload();
});

