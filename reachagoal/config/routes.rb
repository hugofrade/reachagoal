Reachagoal::Application.routes.draw do

  devise_for :users
  resources :objectives
  post "/objectives/:objective_id/add_value" => "objectives#add_value"
  
  root to: 'objectives#index'
  
end
