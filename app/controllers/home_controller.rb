class HomeController < ApplicationController
	def index
		@seats = Seat.all
		@users = User.all
	end
end
