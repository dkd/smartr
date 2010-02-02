ActionController::Routing::Routes.draw do |map|
  
  map.connect "questions/hot/:page", :controller => :questions, :action => :index_for_hot, :page => nil
  map.connect "questions/active/:page", :controller => :questions, :action => :index_for_active, :page => nil
  map.connect "questions/unanswered/:page", :controller => :questions, :action => :index_for_unanswered, :page => nil
  map.connect "questions/page/:page", :controller => :questions, :action => :index
  
  map.resources :questions do |question|
    question.resources :answers
  end
  
  map.resources :comments
  map.connect "tags/:tag", :controller => :tags, :action => :index
  map.connect "users/search/:name", :controller => :users, :action => :index
  map.connect "tags", :controller => :tags, :action => :index
  map.connect "questions/tagged/:tag", :controller => :questions, :action => :index
  map.resources :votes
  map.resources :users
  map.resource :user_session
  map.resources :favourites
  map.root :controller => "questions", :action => "index"
  
end
