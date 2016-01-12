class RecordsController < ApplicationController


  def index
    @record = Record.all
  end

  def show
  end

	def new
		@record = Record.new
	end

	def create
		@record = Record.new(record_params)
		if @record.save
			update_total_hours(record_params[:user_id])
			redirect_to home_path
		else
			render 'new'
		end
	end

	private
	def record_params
		params.require(:record).permit(:seat_id, :user_id, :usage)
	end

	def update_total_hours(user_id)
		records = Record.where(user_id: user_id)
		user = User.find(user_id)
		total_usage = 0
		records.each do |record|
			total_usage += record.usage 
		end
		user.total_hours = total_usage
		user.save
	end
end
