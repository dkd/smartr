(function() {
  var top_message;
  top_message = function(message, type) {
    return $("#top-flash").find("p").html(message).parent().slideDown("slow");
  };
}).call(this);
