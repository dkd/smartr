module QuestionsHelper
  def submenu(active)
      menu = []
      menu << {:name => "Latest", :id => "latest", :link => questions_path}
      menu << {:name => "Hot", :id => "hot", :link => url_for(:controller => :questions, :action => :index_for_hot)}
      menu << {:name => "Active", :id => "active", :link => url_for(:controller => :questions, :action => :index_for_active)}
      menu << {:name => "Unanswered", :id => "unanswered", :link => url_for(:controller => :questions, :action => :index_for_unanswered)}
      build_menu(menu, active)
  end
end
