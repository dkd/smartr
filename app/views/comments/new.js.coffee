$('#<%="#{@comment.commentable_type}-comments-#{@comment.commentable_id} .comment-new"%>').hide()
html = '<%=escape_javascript(render("new", :comment => @comment, :url => comments_path))%>'
$('#<%="#{@comment.commentable_type}-comments-#{@comment.commentable_id}"%>').append(html)