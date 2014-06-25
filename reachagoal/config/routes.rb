Reachagoal::Application.routes.draw do

  devise_for :users
  resources :objectives
  post "/objectives/:objective_id/add_value" => "objectives#add_value"
  
  get "objectives/index"
  get "public/index"
  get "dashboard" => "private#user_dashboard"
 
 #  authenticated :user do
# 	  root :to => "objectives#index"
#   end

  root :to => "public#index"

end


