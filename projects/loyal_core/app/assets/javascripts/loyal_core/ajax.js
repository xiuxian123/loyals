
var marchBackstage = (function(mod){
  var _getMarchData = function(obj){
    return {
      type:   obj.attr('march-type') || null,
      id:     obj.attr('march-id') || null,
      action: obj.attr('march-action') || null,
      obj:    obj
    };
  }

  // 弹出 错误对话框
  mod.tryAjaxErrorDialog = function(data){
    if(mod.isUnauthorized(data)) {
      alert(data.response.error);
      return false;
    } else {
      return true;
    }
  }

  // 没有登录的
  mod.isUnauthorized = function(data){
    return data.response.code == 'unauthorized';
  }

  // 绑定喜欢操作
  mod.bindLikeActions = function(){
    $('[march-on="ajax"]').on('click', function(){
      var _data = _getMarchData($(this));

      if(_data.action == 'like'){
        $.ajax(
          {
            url: "/ajax/core/like_tracks/" + _data.type + "/" + _data.id + '/touch.json',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
              switch(data.result.code){
                case 'undo':
                  _data.obj.find('img.liked').css('display', 'none');
                _data.obj.find('img.unlike').css('display', 'inline');
                _data.obj.find('.count').text(data.result['count']);
                break;
                case 'like':
                  _data.obj.find('img.unlike').css('display', 'none');
                _data.obj.find('img.liked').css('display', 'inline');
                _data.obj.find('.count').text(data.result['count']);
                break;
              }
            },
            error: function(xhr, status, error) {
              var data = eval("(" + xhr.responseText + ")");
              mod.tryAjaxErrorDialog(data);
            }
          }
        );
      }
    });
  }

  // 绑定评价操作
  mod.bindRatingActions = function(){
    $('[march-on="ajax"]').on('click', function(){
      var _data = _getMarchData($(this));

      switch(_data.action){
        case 'up':    // 顶
        case 'down':  // 踩
        $.ajax(
          {
            url: "/ajax/core/rating_tracks/" + _data.type + "/" + _data.id + "/" + _data.action + '.json',
            success: function(data) {
              // data:
              //  {
              //    response: {
              //      status: 200,
              //      code: 'success'
              //    }
              //  }
              switch(data.result.code){
                case 'already':
                  alert('您已经评价过了');
                case 'up':
                case 'down':
                  _data.obj.find('.count').text(data.result[_data.action + '_rating']);
                break;
              }
            },
            error: function(xhr, status, error) {
              var data = eval("(" + xhr.responseText + ")");
              mod.tryAjaxErrorDialog(data);
            }
          }
        );
        break;
        default:
          break;
      };
    });
  }

  // marchBackstage.retrySimpleCaptcha(this);
  mod.retrySimpleCaptcha = function(obj, url){
    var currentRetryLink = $(obj);
    $.get(url, {time: (new Date()).valueOf(), format: 'json'}, function(data){
      if(data.response.code == 'success'){
        var currentCaptchaZone = currentRetryLink.parents(".simple_captcha:first");
        currentCaptchaZone.find('img.captcha-image').attr('src', data.simple_captcha_options.image_url);
        currentCaptchaZone.find('input.captcha-key').val(data.simple_captcha_options.captcha_key);
      }
    });

    return false;
  }

  return mod;
})(window.marchBackstage || {});

$(function(){
  marchBackstage.bindLikeActions();
  marchBackstage.bindRatingActions();
});

