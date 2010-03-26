// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


Array.prototype.contains = function (element)
{
    for (var i = 0; i < this.length; ++i) {
        if (this[i] == element) {
            return true;
        }
    }
    return false;
}
var interesting_tags = new Array();
var uninteresting_tags = new Array();
function top_message(message, type){
  $("#top-flash").find("p").html(message).parent().slideDown("slow");
}

$(document).ready(function(){
  $("div.tag-search input").keyup(function(){
    var tag = $(this).val();
    $.ajax({type: "GET",
            url: "/tags?q=" + tag,
            success: function(data){
              $("div.tag-list").html(data);
            }});
    
  });
  
  $("div.user-search input").keyup(function(){
    var tag = $(this).val();
    $.ajax({type: "GET",
            url: "/users/search/?q=" + tag,
            success: function(data){
              if(data){
                var header = "<tr>" + $("div.user-list table tr").html() + "</tr>";
                $("div.user-list table").html(header + data);
                $("div.user-list .no-result").hide();
                $("div.user-list table").show();
              }
              else{
                $("div.user-list table").hide();
                $("div.user-list .no-result").fadeIn();
              }
            }});
    
  });
  
  //$("#top-flash").slideDown("slow");
  $("#top-flash span").click(function(){$(this).parent().slideUp("fast")});
  
  
  $(".question-edit form, .answer-edit form").submit(function(){
    $("textarea.markdown").parent().find("input.plain").val($("textarea.markdown").val());
  });
  
  /* Highlight interesting questions */
  $(".tags.interesting a").each(function(i){
    interesting_tags.push($(this).html());
  });
  
  $(".question-list .tags a").each(function(i){
    if(interesting_tags.contains($(this).html())){
      $(this).parents(".question-list").addClass("highlight-question");
    }
  });
  
  $(".highlight-question").each(function(i){
    //jQuery.easing.def = "easeInCubic";
    $(this).animate({"backgroundColor":"#FFF4BF"}, 4000);
  });
  
  
  /* Fade uninteresting questions */
  $(".tags.uninteresting a").each(function(i){
    uninteresting_tags.push($(this).html());
  });
  
  $(".question-list .tags a").each(function(i){
    if(uninteresting_tags.contains($(this).html())){
      $(this).parents(".question-list").addClass("fade-question");
    }
  });

  $(".fade-question").each(function(i){
    //jQuery.easing.def = "easeInCubic";
    $(this).animate({"opacity":"0.5"}, 4000);
  });
  
  /* Show values from rel attribute in form fields */
  $("input.toggle").toggleValue();
  
  /* Fancy question button */
  $(".tags a, #sidebar a.new_question, #menu li, .tag-list span a").click(function(){
      $(this).effect("pulsate", { times:2, mode: "show" }, 200);

  });
  $("input[type=text],input[type=password]").focus(function()
    {
      $(this).addClass("active");
    }
  );
  $("input[type=text],input[type=password]").blur(function()
    {
      $(this).removeClass("active");
    }
  );
  
  /* Tag auto-completion */
 
  $("input.tags").autocomplete('/tags.json', {
      dataType: 'json',
      parse: function(data) {
          var rows = new Array();
          for(var i=0; i<data.length; i++){
              rows[i] = { data: data[i], value:data[i], result:data[i]};
          }
          return rows;
      },
      formatItem: function(row, i, n) {
          return row;
      },
      multiple: true,
      autoFill: true
  });
  
  $(".status a").hover(
    function(){
    
      $(this).toggleClass("accepted");
    
    },
    function(){
    
      $(this).toggleClass("accepted");
    
    }
  );
  
     hljs.tabReplace = '    ';
     hljs.initHighlightingOnLoad();
     
     $("textarea").tabby();
   
   $("#wmd-input").wmd();
     
});
