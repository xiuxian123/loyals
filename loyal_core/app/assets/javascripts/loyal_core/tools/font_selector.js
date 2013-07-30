var loyalCoreFontSelect = (function(mod){
  mod._config = {
    selectors: {
      fontSize: '.loyal-core-font-size-selector a'
    },
    cookies: {
      fontSize: 'loyal-core-font-size'
    },
    fontSizeMap: {
      small: '100%',
      medium: '130%',
      large: '160%'
    },
    defaultFontSize: 'small'
  }

  mod._getCookieName = function(name){
    return mod._config.cookies[name]; 
  }

  mod._getActionLinks = function(name){
    return $(mod._config.selectors[name]);
  }

  mod._getFontSizeMap = function(){
    return mod._config.fontSizeMap;
  }

  mod._getFontSize = function(name){
    var fontSizeMap = mod._getFontSizeMap();
    return fontSizeMap[name] || fontSizeMap[mod._config.defaultFontSize];
  }

  // private
  mod._bindFontSizeLinksActions = function(){
    mod._getActionLinks('fontSize').on('click', function(){
      var fontSizeName = $(this).attr('loyal-data-type-size');
      var selector = $(this).parent().find("[name=font-selector-size]").val();

      var fontSize = mod._getFontSize(fontSizeName);

      $.cookie(mod._getCookieName('fontSize'), fontSizeName, { expires: 2, path: '/' });
      
      mod._setFontSizeCss($(selector), fontSize);
    }); 
  }

  // 设置正文的字体大小
  mod._setFontSizeCss = function(worker, fontSize){
    worker.css('font-size', fontSize);
  }

  mod._loadFontSizeFromStore = function(){
    var actionLinks = mod._getActionLinks('fontSize');

    var selector = actionLinks.parent().find("[name=font-selector-size]").val();
    var fontSizeName = $.cookie(mod._getCookieName('fontSize'));
    var fontSize = mod._getFontSize(fontSizeName);

    // 设置控制链接的字体
    actionLinks.each(function(){
      var current = $(this);
      var currentFontSizeName = current.attr('loyal-data-type-size');
      current.css('font-size', mod._getFontSize(currentFontSizeName));
    });

    mod._setFontSizeCss($(selector), fontSize);
  }

  // public
  mod.onload = function(){
    // 首先绑定按钮 事件
    mod._bindFontSizeLinksActions();
    mod._loadFontSizeFromStore();
  }

  return mod;
})(window.loyalCoreFontSelect || {});

$(function(){
  loyalCoreFontSelect.onload();
});

