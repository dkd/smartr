Smartr::Application.routes.draw do
  
  devise_for :users
  
  namespace :admin do
    resources :comments
    resources :answers
    resources :questions
    resources :users
  end
  
  match "/questions/page/:page", :to => "questions#index"
  match "/questions/hot(/:page)", :to => "questions#hot"
  match "/questions/active(/:page)", :to => "questions#active"
  match "/questions/unanswered(/:page)", :to => "questions#unanswered"
  match "/questions/tagged/:tag(/:page)", :to => "question#index"
  
  resources :questions, :except => [:show, :edit] do
    
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

  match "/questions/:id(/:friendly_id)", :to => "questions#show", :as => :question
  match "/questions/:id/:friendly_id/edit", :to => "questions#edit"
  
  scope "/questions/:question_id/:friendly_id/" do
    get "answer/:id/edit", :to => "answers#edit", :as => :edit_question_answer
    put "answer/:id", :to => "answers#update", :as => :question_answer
    post "answers", :to => "answers#create", :as => :question_answers
  end
  
  match "/admin", :to => "admin#index"
  

  
  resources :comments
  resources :tags, :only => [:index]
  resources :votes, :only => [:create]
  
  resources :users, :except => [:destroy] do
    
    collection do
      get :who_is_online
      get :search
    end
    
    member do
      get :tag_cloud
      get :reputation
    end
    
    resources :favourites, :only => [:index]
    
  end
  
  resources :favourites, :only => [:toggle] do
    member do
      post :toggle
    end
  end
  
  namespace :api do
    namespace :v1 do
      resources :questions, :only => [:index]
      resources :users, :only => [:index]
    end
  end
  
  root :to => 'questions#index'
  match '*a', :to => 'errors#routing' 
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