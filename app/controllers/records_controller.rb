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
			redirect_to home_path
		else
			render 'new'
		end
	end

	private
	def record_params
		params.require(:record).permit(:seat_id, :user_id, :usage)
	end
end
