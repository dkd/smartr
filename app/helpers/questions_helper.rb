module QuestionsHelper
  def submenu(active)
      menu = []
      menu << {:name => "Latest", :id => "latest", :link => questions_path(:page => nil)}
      menu << {:name => "Hot", :id => "hot", :link => url_for(:controller => :questions, :action => :index_for_hot, :page => nil)}
      menu << {:name => "Active", :id => "active", :link => url_for(:controller => :questions, :action => :index_for_active, :page => nil)}
      menu << {:name => "Unanswered", :id => "unanswered", :link => url_for(:controller => :questions, :action => :index_for_unanswered, :page => nil)}
      build_menu(menu, active)
  end
end
