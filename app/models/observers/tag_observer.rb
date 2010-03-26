class TagObserver < ActiveRecord::Observer

  def after_update(tag)
    ActionController::Base.new.expire_fragment "questions_sidebar_tags_view"
  end
  
  def after_save(tag)
    ActionController::Base.new.expire_fragment "questions_sidebar_tags_view"
  end
  
  def after_destroy(tag)
     ActionController::Base.new.expire_fragment "questions_sidebar_tags_view"
  end
  
end
