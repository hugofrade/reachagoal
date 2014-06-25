Reachagoal::Application.routes.draw do

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
  get "public/index" 

 

end


