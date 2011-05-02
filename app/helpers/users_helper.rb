module UsersHelper
  include ActsAsTaggableOn::TagsHelper

  def user_submenu(active)
       menu = []
       menu << {:name => t("users.winner"), :id => "winner", :link => users_path(:page => nil)}
       #menu << {:name => "Loser", :id => "loser", :link => url_for(:controller => :users, :action => :index, :page => nil)}
       menu << {:name => t("users.who_is_online"), :id => "who_is_online", :link => who_is_online_users_path}
       build_menu(menu, active)
   end

  def user_show_submenu(active)
      menu = []
      menu << {:name => t("users.detail"), :id => "detail", :link => user_path(:id => @user.id)}
      menu << {:name => t("users.reputation.history"), :id => "reputation", :link => reputation_user_path(@user)}
      menu << {:name => t("users.edit_account"), :id => "edit", :link => edit_user_registration_path}  if user_signed_in? && current_user == @user
      menu << {:name => t("users.favourites"), :id => "favourites", :link => user_favourites_path(@user)}
      build_menu(menu, active)
  end

end