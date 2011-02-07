class CommentObserver < ActiveRecord::Observer
  
  def before_save(comment)
    comment.body = Sanitize.clean(comment.body, :elements => ['a'])
  end
  
  def after_create(comment)
    if comment.commentable.class.name == "Question"
      commentable = comment.commentable
      if comment.user != commentable.user && commentable.send_email == true 
        UserMailer.deliver_question_update(commentable, comment)
      end
    end
  end
  
end
