module QuestionsHelper

  def submenu(active)
      menu = []
      menu << {:name => I18n.t(:"questions.sub_menu.latest"), :id => "latest", :link => questions_path(:page => nil)}
      menu << {:name => I18n.t(:"questions.sub_menu.hot"), :id => "hot", :link => url_for(:controller => :questions, :action => :index_for_hot, :page => nil)}
      menu << {:name => I18n.t(:"questions.sub_menu.active"), :id => "active", :link => url_for(:controller => :questions, :action => :index_for_active, :page => nil)}
      menu << {:name => I18n.t(:"questions.sub_menu.unanswered"), :id => "unanswered", :link => url_for(:controller => :questions, :action => :index_for_unanswered, :page => nil)}
      build_menu(menu, active)
  end
end