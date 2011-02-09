class CommentObserver < ActiveRecord::Observer
  
  def before_save(comment)
    comment.body = Sanitize.clean(comment.body, :elements => ['a'])
  end
  
  def after_create(comment)
    if comment.commentable.class.name == "Question"
      commentable = comment.commentable
      if (comment.user != commentable.user) && (commentable.send_email == true) 
        UserMailer.question_update(commentable, comment).deliver
      end
    end
  end
  
end
