Reachagoal::Application.routes.draw do

  resources :currencies

  resources :moneyboxes

  resources :friends

  resources :badges

  resources :categories

  devise_for :users
  
  resources :objectives
  
  
  unauthenticated :user do
 	  root :to => "public#index", :as => "unauthenticated"
   end
 
  authenticated :user do
  	root :to => "private#user_dashboard" 
  end
  
  get "dashboard" => "private#user_dashboard"
  post "/objectives/:objective_id/add_value" => "objectives#add_value"
  post "/objectives/:objective_id/add_comment" => "objectives#add_comment"

  get "remove_value/:id" => "objectives#remove_value", :as=>"remove_value"
  get "remove_comment/:id" => "objectives#remove_comment", :as=>"remove_comment"

  get "public/index" 
  

  get "publicprofile/:id" => "private#public_profile", :as=>"public_profile"
  get "add_friend/:id" => "private#add_friend", :as=>"add_friend"
  get "badge/new/:id" => "badge#create", :as=>"give_badge"

  get "remove_friend/:id" => "private#remove_friend", :as=>"remove_friend"
  
  get "ajax_challenges" => "private#ajax_challenges"


end


