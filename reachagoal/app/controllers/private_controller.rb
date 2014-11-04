class PrivateController < ApplicationController
	before_action :authenticate_user!
	
	def user_dashboard
		@user_badges = UserBadges.where("receiver_id = ?", current_user.id).order("id DESC")
		@user_badges_paginate = UserBadges.where("receiver_id = ?", current_user.id).order("id DESC").paginate(:page => params[:page], :per_page => 3)
		@last_values_added = ObjectiveValue.where("user_id = ?", current_user.id).order("id DESC").first(5)
		@user_friends=current_user.friends.paginate(:page => params[:page], :per_page => 5)
	end
	
	def public_profile
		@user = User.find(params[:id])
		@badges = Badge.all
		@user_badges = UserBadges.where("receiver_id = ?", @user.id).order("id DESC")
		@user_badges_paginate = UserBadges.where("receiver_id = ?", @user.id).order("id DESC").paginate(:page => params[:page], :per_page => 3)
		@user_friends=@user.friends.paginate(:page => params[:page], :per_page => 1)
		@last_values_added = ObjectiveValue.where("user_id = ?", @user.id).order("id DESC").first(5)

	end
	
	def ajax_challenges
		user_objectives = UserObjective.where("user_id=?", current_user.id)
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
	
	
	def ajax_challenges_pp
		user_objectives = UserObjective.where("user_id=?", params[:id])
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
	
	def ajax_badges
		unless params[:id].blank?
			@user_badges = UserBadges.where("receiver_id = ?", params[:id]).order("id DESC")
			@user = User.find(params[:id])
		else
			@user_badges = UserBadges.where("receiver_id = ?", current_user.id).order("id DESC")
		end
		@user_badges_paginate = @user_badges.paginate(:page => params[:page], :per_page => 3)
		render template: "private/_badges", layout: false

	end
	
	def ajax_friends
		unless params[:id].blank?
			@user = User.find(params[:id])
			@user_friends=@user.friends.paginate(:page => params[:page], :per_page => 1)
		else
			@user_friends=current_user.friends.paginate(:page => params[:page], :per_page => 5)
		end
		render template: "private/_friends", layout: false

	end
	

	
	def add_badge
		@badge = UserBadges.new()
		@badge.giver_id = current_user.id
		@badge.receiver_id = params[:friend_id]
		@badge.statement = params[:statement]
		@badge.badge_id = params[:badge_id]
		@badge.save
		redirect_to public_profile_path(params[:friend_id]), notice: 'Ofereceste um crachá ao utilizador com sucesso'
	end
	
	def add_friend
		if params[:email].blank?
			id = params[:id]
		else
			id = User.where("email = ?", params[:email]).first.id
		end
		
		if id == current_user.id
			if params[:email].blank?
				redirect_to public_profile_path(params[:id]), notice: "Impossível adicionar-se a si mesmo como amigo"
			else
				redirect_to dashboard_path, notice: "Impossível adicionar-se a si mesmo como amigo"
			end
		else			
			@friend1 = Friend.new(user_id: current_user.id, friend_id: id)
			@friend2 = Friend.new(user_id: id, friend_id: current_user.id)
			@friend1.state = @friend2.state = 1
			@friend1.save
			@friend2.save
			
			if params[:email].blank?
				redirect_to public_profile_path(params[:id])		
			else
				redirect_to dashboard_path
			end
		end
	end
	
	def remove_friend
		@friend1=Friend.where("user_id=? and friend_id=?", current_user, params[:id]).first.destroy
		@friend2=Friend.where("user_id=? and friend_id=?", params[:id], current_user).first.destroy
		redirect_to public_profile_path(params[:id])
	end
	
	

	
end
