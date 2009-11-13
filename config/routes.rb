ActionController::Routing::Routes.draw do |map|
  map.resources :comments

  map.resources :answers, :has_many => :comments

  map.resources :questions, :has_many => :comments

  map.resource :account, :controller => "users"
  map.resources :users
  map.resource :user_session
  map.root :controller => "home", :action => "index"
end
