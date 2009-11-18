ActionController::Routing::Routes.draw do |map|
  
  map.connect "questions/page/:page", :controller => :questions, :action => :index
  map.resources :questions do |question|
    question.resources :answers do |answer|
      answer.resources :comment => [:post, :put], :controller => :answers do |comment|
        comment.resources :comments, :controller => :comments
      end
    end
    question.resources :comments, :controller => :comments
  end
  map.connect "tags/:tag", :controller => :tags, :action => :index
  map.connect "tags", :controller => :tags, :action => :index
  map.connect "questions/tagged/:tag", :controller => :questions, :action => :index
  map.resources :votes
  map.resources :users
  map.resource :user_session
  map.root :controller => "questions", :action => "index"
end
