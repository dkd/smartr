module QuestionsHelper

  def question_submenu(active)
      menu = []
      menu << {:name => I18n.t(:"question.sub_menu.latest"), :id => "latest", :link => root_url}
      menu << {:name => I18n.t(:"question.sub_menu.hot"), :id => "hot", :link => hot_questions_path}
      menu << {:name => I18n.t(:"question.sub_menu.active"), :id => "active", :link => active_questions_path}
      menu << {:name => I18n.t(:"question.sub_menu.unanswered"), :id => "unanswered", :link => unanswered_questions_path(params)}
      build_menu(menu, active, "nav nav-pills")
  end
  
  def facet(name, results)
    render :partial => "facet", :locals => {:facet => name, :results => results }
  end
  
end