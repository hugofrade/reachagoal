class Friend < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => 'User', :foreign_key => 'friend_id'
	
	
	def Friend.is_friend?(user_id, friend_id)
		return !Friend.where("user_id=? and friend_id=? and state=?", user_id, friend_id, "1" ).blank?
	end
	
# 	def Friend.number_of_friends(user)
# 		@total=0
# 		if user.friends.length >0
# 			user.friends.each do 
# 				@total++
# 			end
# 	  	end
# 	  	return @total
# 	end
	
end
