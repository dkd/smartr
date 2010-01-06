class CommentObserver < ActiveRecord::Observer
  
  def before_save(comment)
    comment.body = Sanitize.clean(comment.body, :elements => ['a'])
  end
  
end
