module CommentsHelper
  def comments_order_menu(active, commentable)
      @question ||= @parent
      menu = []
      menu << { :id => "latest", 
                :link => link_to (I18n.t(:"comments.order.latest"), comments_path(:model => commentable.class.name, :id => commentable.id, :comments_order => "latest"), :remote => true) }
      menu << { :id => "reputation", 
                :link => link_to (I18n.t(:"comments.order.reputation"), comments_path(:model => commentable.class.name, :id => commentable.id, :comments_order => "reputation"), :remote => true) }
     build_ajax_menu(menu, active)
  end
end