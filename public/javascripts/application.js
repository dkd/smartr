// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function top_message(message, type){
  $("#top-flash").find("p").html(message).parent().slideDown("slow");
}

$(document).ready(function(){
  $("div.tag-search input").keyup(function(){
    var tag = $(this).val();
    $.ajax({type: "GET",
            url: "/tags/" + tag,
            success: function(data){
              $("div.tag-list").html(data);
            }});
    
  });
  
  $("div.user-search input").keyup(function(){
    var tag = $(this).val();
    $.ajax({type: "GET",
            url: "/users/search/" + tag,
            success: function(data){
              $("div.user-list").html(data);
            }});
    
  });
  
  //$("#top-flash").slideDown("slow");
  $("#top-flash span").click(function(){$(this).parent().slideUp("fast")});
  
  
  $(".question-edit form, .answer-edit form").submit(function(){
    $("textarea.markdown").parent().find("input.plain").val($("textarea.markdown").val());
  });
  $(".highlight-question").each(function(i){
    //jQuery.easing.def = "easeInCubic";
    $(this).animate({"backgroundColor":"#FFF4BF"}, 4000);
  });
  
  $(".fade-question").each(function(i){
    //jQuery.easing.def = "easeInCubic";
    $(this).animate({"opacity":"0.5"}, 4000);
  });
  
  $("input.toggle").toggleValue();
  
  $(".tags a, #sidebar a.new_question").click(function(){
      $(this).effect("pulsate", { times:2, mode: "show" }, 200);

  });
  $("#search_searchstring").focus(function()
    {
      $(this).addClass("active");
    }
  );
  $("#search_searchstring").blur(function()
    {
      $(this).removeClass("active");
    }
  );
  
  wmd_options = {
			// format sent to the server.  Use "Markdown" to return the markdown source.
			output: "Markdown",

			// line wrapping length for lists, blockquotes, etc.
			lineLength: 40,

			// toolbar buttons.  Undo and redo get appended automatically.
			buttons: "bold italic | link blockquote code image | ol ul heading hr",

			// option to automatically add WMD to the first textarea found.  See apiExample.html for usage.
			autostart: true
		};
     hljs.tabReplace = '    ';
     hljs.initHighlightingOnLoad();
     
     $("textarea").tabby();
     
});
