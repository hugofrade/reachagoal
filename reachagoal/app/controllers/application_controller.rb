class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  layout :layout_by_resource
  
  protect_from_forgery with: :exception
  
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  
  
  
	def layout_by_resource
		if devise_controller? && resource_name == :user && action_name != "edit"
			"public"
		else
			"application"
		end
	end



  protected

  def configure_devise_permitted_parameters
    registration_params = [:name, :email, :password, :password_confirmation, :photo, :cover, :city, :biography, :facebook_user, :surname, :country]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    end
  end 

  
  
#   def after_sign_in_path_for(resource)
#   	objectives_path
#   end
#   
  
end
