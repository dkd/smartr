ActionController::Routing::Routes.draw do |map|
  map.resources :comments

  map.resources :answers, :has_many => :comments

  map.resources :questions, :has_many => :comments
  map.connect "tags/:tag", :controller => :tags, :action => :index
  map.connect "tags", :controller => :tags, :action => :index
  map.connect "questions/tagged/:tag", :controller => :questions, :action => :index
  
  #map.resources :tags
  map.resources :votes
  map.resources :users
  map.resource :user_session
  map.root :controller => "questions", :action => "index"
end
