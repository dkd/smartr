module UsersHelper
  
  def submenu(active)
       menu = []
       menu << {:name => "Winner", :id => "winner", :link => users_path(:page => nil)}
       menu << {:name => "Loser", :id => "loser", :link => url_for(:controller => :users, :action => :index, :page => nil)}
       
       build_menu(menu, active)
   end
  
end
