Reachagoal::Application.routes.draw do

  resources :currencies

  resources :moneyboxes

  resources :friends

  resources :categories

  devise_for :users
  
  resources :objectives, except: :index
  
  
  unauthenticated :user do
 	  root :to => "public#index", :as => "unauthenticated"
   end
 
  authenticated :user do
  	root :to => "private#user_dashboard" 
  end
  
  get "dashboard" => "private#user_dashboard"
  post "/objectives/:objective_id/add_value" => "objectives#add_value", :as => "add_value"
  post "/objectives/:objective_id/add_comment" => "objectives#add_comment", :as => "add_comment"
  post "/objectives/:objective_id/add_friend/:friend_id" => "objectives#add_friend", :as=>"add_friend_objective"


  get "remove_value/:id" => "objectives#remove_value", :as=>"remove_value"
  get "remove_comment/:id" => "objectives#remove_comment", :as=>"remove_comment"

  get "public/index" 
  

  get "publicprofile/:id" => "private#public_profile", :as=>"public_profile"

  post "publicprofile/add_badge/:friend_id" => "private#add_badge", :as=>"add_badge"

  post "add_friend/" => "private#add_friend", :as=>"add_friend_email"
  get "add_friend/:id" => "private#add_friend", :as=>"add_friend"
  get "remove_friend/:id" => "private#remove_friend", :as=>"remove_friend"
  
  get "ajax_challenges/:id" => "private#ajax_challenges"
  get "ajax_challenges" => "private#ajax_challenges"

  get "ajax_values/:id" => "objectives#ajax_values"
  get "ajax_badges/:id" => "private#ajax_badges"
  get "ajax_badges/" => "private#ajax_badges"
    
  get "ajax_friends/:id" => "private#ajax_friends"
  get "ajax_friends/" => "private#ajax_friends"
  
  
  
end


