module CommentsHelper
  def comments_order_menu(active, anchor)
      @question ||= @parent
      menu = []
      menu << { :name => I18n.t(:"comments.order.latest"), 
                :id => "latest", 
                :link => question_url(@question, :id => @question.id, :comments_order => "latest", :anchor => anchor) }
      menu << { :name => I18n.t(:"comments.order.reputation"), 
                :id => "reputation",
                :link => question_url(@question, :id => @question.id, :comments_order => "reputation", :anchor => anchor)  }
      build_menu(menu, active)
  end
end