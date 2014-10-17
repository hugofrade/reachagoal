class PrivateController < ApplicationController
	before_action :authenticate_user!
	
	def user_dashboard
	
	end
	
	def ajax_challenges
		user_objectives = UserObjective.where("user_id=?", current_user)
		@challenges = []
		if params["estado"] != "aaa"
			if params["estado"] == "1"
				user_objectives.each do |user_objective|
				  @challenges << user_objective if user_objective.objective.completed_percentage < 100
				end
			elsif params["estado"] == "2"
				
				user_objectives.each do |user_objective|
				  @challenges << user_objective if user_objective.objective.completed_percentage == 100
				end
			else
				@challenges = user_objectives
			end
		elsif params["catid"] != "aaa"
			user_objectives.each do |user_objective|
			  @challenges << user_objective if (user_objective.objective.category_id.to_i == params["catid"].to_i)
			end
		else
			@challenges = user_objectives
		end
		
		render :template => "layouts/_challenge", :layout => false
	end
	
	def public_profile
		@user = User.find(params[:id])
	end
	
	def add_friend
		@friend1 = Friend.new(user_id: current_user.id, friend_id: params[:id])
		@friend2 = Friend.new(user_id: params[:id], friend_id: current_user.id)
		@friend1.state = @friend2.state = 1
		@friend1.save
		@friend2.save
		redirect_to public_profile_path(params[:id])
	end
	
	def remove_friend
		@friend1=Friend.where("user_id=? and friend_id=?", current_user, params[:id]).first.destroy
		@friend2=Friend.where("user_id=? and friend_id=?", params[:id], current_user).first.destroy
		redirect_to public_profile_path(params[:id])
	end
	
	

	
end
