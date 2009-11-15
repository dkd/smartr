// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function update_tag_list(tag){
  
  
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
});