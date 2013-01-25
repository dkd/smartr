// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require wysiwym/Markdown.Converter
//= require wysiwym/wysiwym
//= require jquery.toggle-value
//= require jquery.typewatch
//= require jquery.textarea
//= require jquery-autocomplete/jquery.autocomplete.pack
//= require highlight/highlight.pack
//= require jquery.gritter.min

$(document).ajaxSend(function(event, xhr, settings) {
  xhr.setRequestHeader("Accept", "text/javascript, application/javascript");
});

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
    $.ajax(
            {
              type: "GET",
              url: "/tags.js?tags[q]=" + tag,
              processData: false,
              dataType: "html",
              success: function(data){
                $("#taglist").html(data);
              }
            }
          );
  });

  $("div.user-search input").keyup(function(){
    var tag = $(this).val();
    $.ajax({type: "GET",
            url: "/users/search/?q=" + tag,
            success: function(data){
              if(data){

                var header = "<tr>" + $("table.user-list tr").html() + "</tr>";
                $("table.user-list").html(header + data);
								console.log("header");
                $("table.user-list .no-result").hide();
                $("table.user-list").show();
              }
              else{
                $("table.user-list").hide();
                $("table.user-list .no-result").fadeIn();
              }
            }});

  });

  //$("#top-flash").slideDown("slow");
  $("#top-flash span").click(function(){$(this).parent().slideUp("fast")});


  //$(".question-edit form, .answer-edit form").submit(function(){
  //  $("textarea.markdown").parent().find("input.plain").val($("textarea.markdown").val());
  //});

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

      if($(this).attr("href") == undefined){

        if($(this).children("a:first").length > 0) {
          window.location.href = $(this).children("a:first").attr("href");
        }
      }
  });


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

  /* Question auto-completion */

  $("#question_searchstring").autocomplete('/questions/search.json', {
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
      multiple: false,
      autoFill: false
  });
  
  $("#question_searchstring").typeWatch({callback: function() {
    	$.ajax({ url: "/questions/search.js",
	             data: "question[searchstring]="+$("#question_searchstring").val(),
	             dataType: "html",
	             success:function(data) {
	                      $("#ajax-search").html(data).show();
	                     }
	    });
	    if ($(this).val() == "") {
	      $("#ajax-search").hide().html("");
	    }
  	},
	wait: 250,
	highlight: true,
	captureLength: 3
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

   $("#markdown-editor").wysiwym(Wysiwym.Markdown, {});
   
   if($("#markdown-editor").length == 1) {
     var converter = new Markdown.Converter({});
     console.debug(converter);
     var update_live_preview = function() {
      var content = $("#markdown-editor").val();
      var html = converter.makeHtml(content);
      $('#markdown-preview').html(html);
      
     }
     $(".wysiwym-help-toggle").hide();
     setInterval(update_live_preview, 200);
   }


	$(document).ajaxSend(function(e, xhr, options) {
	  var token = $("meta[name='csrf-token']").attr("content");
	  xhr.setRequestHeader("X-CSRF-Token", token);
	});

	// Popover
	$("a[rel=popover]").popover();
	

});
