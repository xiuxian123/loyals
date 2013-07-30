var loyalAppendParamsReturnTo = (function(mod){
  // public
  mod.onload = function(){
    var currentUrl = window.location.href;

    $('a[loayl-append-params-return-to=true]').each(function(){
      if($(this).attr('href').indexOf('?') < 0){
        $(this).attr('href', (
          $(this).attr('href') + "?return_to=" + encodeURIComponent(currentUrl)
        ));
      }
    });
  }

  return mod;
})(window.loyalAppendParamsReturnTo || {});

$(function(){
  loyalAppendParamsReturnTo.onload();
});

