module UsersHelper
  
  def submenu(active)
       menu = []
       menu << {:name => "Winner", :id => "winner", :link => users_path(:page => nil)}
       #menu << {:name => "Loser", :id => "loser", :link => url_for(:controller => :users, :action => :index, :page => nil)}
       menu << {:name => "Who is online?", :id => "who_is_online", :link => who_is_online_users_path}
       build_menu(menu, active)
   end
   
  def show_submenu(active)
      menu = []
      menu << {:name => "Detail", :id => "detail", :link => user_path(@user)}
      menu << {:name => "Favourites", :id => "favourites", :link => user_favourites_path(@user)}
      build_menu(menu, active)
  end
   
end
