module UsersHelper
  include ActsAsTaggableOn::TagsHelper

  def user_submenu(active)
       menu = []
       menu << {:name => t("users.winner"), :id => "winner", :link => users_path}
       #menu << {:name => "Loser", :id => "loser", :link => url_for(:controller => :users, :action => :index, :page => nil)}
       menu << {:name => t("users.who_is_online"), :id => "who_is_online", :link => who_is_online_users_path}
       build_menu(menu, active, "nav nav-pills")
   end

  def user_show_submenu(active)
      menu = []
      menu << {:name => t("users.detail"), :id => "detail", :link => user_path(:id => @user.id)}
      menu << {:name => t("users.reputation.history"), :id => "reputation", :link => reputation_user_path(@user)}
      menu << {:name => t("users.favourites"), :id => "favourites", :link => user_favourites_path(@user)}
      menu << {:name => t("users.questions"), :id => "questions", :link => questions_user_path(@user)} if @user.questions.size > 5
      menu << {:name => t("users.answers"), :id => "answers", :link => answers_user_path(@user)} if @user.answers.size > 5
      build_menu(menu, active, "nav nav-pills")
  end

end