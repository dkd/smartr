Smartr::Application.routes.draw do
  
  devise_for :users
  
  namespace :admin do
    resources :comments
    resources :answers
    resources :questions
    resources :users
  end

  match "/admin", :to => "admin#index"
  match "/questions/hot(/:page)", :to => "questions#hot"
  match "/questions/active(/:page)", :to => "questions#active"
  match "/questions/unanswered(/:page)", :to => "questions#unanswered"
  match "/questions/page/:page", :to => "questions#index"
  match "/questions/tagged/:tag(/:page)", :to => "question#index"
  match "/questions/:id/:friendly_id", :to => "questions#show", :as => :show_question
  match "/questions/:id/:friendly_id/edit", :to => "questions#edit"
  
  resources :questions do
    
    member do 
      put :update_for_toggle_acceptance
    end
    collection do
      get :hot
      get :active
      get :unanswered
      get :search
    end
  end

  resources :answers

  resources :comments
  resources :tags, :only => [:index]
  resources :votes
  
  resources :users do
    
    collection do
      get :who_is_online
      get :search
    end
    
    member do
      get :reputation
    end
    
    resources :favourites
    
  end
  
  
  resources :favourites do
    member do
      put :toggle
    end
  end
  
  root :to => 'questions#index'
  
end

#ActionController::Routing::Routes.draw do |map|
#  
#  map.namespace :admin do |admin|    
#    admin.resources :comments
#    admin.resources :answers
#    admin.resources :questions
#    admin.resources :users
#  end
#  map.connect "admin", :controller => :admin, :action => :index
#  map.connect "questions/hot/:page", :controller => :questions, :action => :index_for_hot, :page => nil
#  map.connect "questions/active/:page", :controller => :questions, :action => :index_for_active, :page => nil
#  map.connect "questions/unanswered/:page", :controller => :questions, :action => :index_for_unanswered, :page => nil
#  map.connect "questions/page/:page", :controller => :questions, :action => :index
#  
#  map.resources :questions, :member => {:update_for_toggle_acceptance => :put} do |question|
#    question.resources :answers
#  end
#  
#  map.resources :comments
#  map.resources :tags
#  map.connect "questions/tagged/:tag", :controller => :questions, :action => :index
#  map.resources :votes
#  
#  map.resources :users, :collection => {:who_is_online => :get, :search => :get}, :member => {:reputation => :get} do |users|
#    users.resources :favourites
#  end
#  
#  map.resource :user_session
#  map.resources :favourites, :only => :none, :member => {:toggle => :put}
#  
#  map.namespace :api do |api|
#    api.namespace :v1 do |v1|
#      v1.resources :questions
#      v1.resources :users
#    end
#  end
#  
#  map.root :controller => :questions, :action => :index
#  
#end