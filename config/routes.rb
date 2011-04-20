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
      get :reputation
    end

    resources :favourites, :only => [:index]

  end

  resources :favourites, :only => [:toggle] do
    member do
      post :toggle
      get :toggle
    end
  end

  match "errors/routing", :to => "errors#routing"

  namespace :api do
    namespace :v1 do
      resources :questions, :only => [:index]
      resources :users, :only => [:index]
    end
  end

  root :to => 'questions#index'
  match '*a', :to => 'errors#routing' 
end