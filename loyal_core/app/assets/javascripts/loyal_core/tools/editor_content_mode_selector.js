$(function(){
  $('select.loyal-editor-content-mode-selector').on('change', function(){
    var currentForm = $(this).parents('form:first');
    // currentForm.appendHTML("<input type='hidden' name='content_mode_changed' value='true'/>");
    currentForm.submit();
  });
});

