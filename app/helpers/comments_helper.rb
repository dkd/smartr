module CommentsHelper
  def comments_order_menu(active)
      menu = []
      menu << {:name => I18n.t(:"comments.order.latest"), :id => "latest", :link => "#{current_url}?comments_order=latest" }
      menu << {:name => I18n.t(:"comments.order.reputation"), :id => "reputation", :link => "#{current_url}?comments_order=reputation" }
      build_menu(menu, active)
  end
end