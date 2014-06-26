class PrivateController < ApplicationController
	before_action :authenticate_user!
	
	def user_dashboard
	
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
