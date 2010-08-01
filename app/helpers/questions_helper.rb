module QuestionsHelper

  def question_submenu(active)
      menu = []
      menu << {:name => I18n.t(:"questions.sub_menu.latest"), :id => "latest", :link => root_url}
      menu << {:name => I18n.t(:"questions.sub_menu.hot"), :id => "hot", :link => hot_questions_path}
      menu << {:name => I18n.t(:"questions.sub_menu.active"), :id => "active", :link => active_questions_path}
      menu << {:name => I18n.t(:"questions.sub_menu.unanswered"), :id => "unanswered", :link => unanswered_questions_path}
      build_menu(menu, active)
  end
end