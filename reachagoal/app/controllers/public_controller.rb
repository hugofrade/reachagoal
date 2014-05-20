class PublicController < ApplicationController

	def index
		@objective = Objective.new
	end

end
