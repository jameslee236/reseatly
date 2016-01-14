class HomeController < ApplicationController
	
	def index
		@seats = Seat.all
		@users = User.all.order('total_hours DESC')
		segment_users
	end

	def segment_users
		Analytics.identify(user_id: "123", traits: { email: "pirate@gmail.com", name: "Kenny Chesney" })
	end
end
