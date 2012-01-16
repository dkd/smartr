$('#<%="#{@comment.commentable_type}-comments-#{@comment.commentable_id} .comment-new"%>').hide()
html = '<div class="comment-new">
				<h3><%=t("comment.new")%></h3>
				<%=escape_javascript(render("form", :comment => @comment, :url => comments_path))%>
				<a href="#" onclick="$.gritter.removeAll();$(\'.comments a.comment-new\').show()
				$(\'.comments div.comment-new\').hide(); return false;" class="cancel"><%=t('cancel')%></a>
				</div>'
$('#<%="#{@comment.commentable_type}-comments-#{@comment.commentable_id}"%>').append(html)