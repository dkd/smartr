jQuery.fn.extend({
  toggleValue : function () {

    return this.each(function() {
      if ($(this).val() == '') { 
        $(this).addClass("grey");        
        $(this).val($(this).attr('title'));
        $(this).parents('form').submit(function(){
          $(this).find('input, textarea').each(function(){
            if ($(this).val() == $(this).attr('title'))
              $(this).val('');
          });
        });
      }
      $(this).focus(function() {      
        if ($(this).val() == $(this).attr('title')) {
            $(this).val('');
            $(this).removeClass("grey");
        }
        $(this).blur(function () {
          if ($.trim($(this).val()) == '' && !$(this).hasClass('no-refill')) {
            $(this).addClass("grey");
            $(this).val($(this).attr('title'));
          }
        });
      });
    });
  }
});