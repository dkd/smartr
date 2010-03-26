class CommentObserver < ActiveRecord::Observer
  
  def before_save(comment)
    comment.body = Sanitize.clean(comment.body, :elements => ['a'])
  end
  
  def after_create(comment)
    if comment.commentable.class.name == "Question"
      UserMailer.deliver_question_update(comment.commentable, comment) if (comment.user != comment.commentable.user && comment.commentable.send_email == true)
    end
  end

end
