class HomeController < ApplicationController
	
	def index
		@seats = Seat.all
		@users = User.all.order('total_hours DESC')
	end

end
