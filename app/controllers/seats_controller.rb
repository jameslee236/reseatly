class SeatsController < ApplicationController
  before_action :set_seat, only: [:show, :edit, :update, :destroy]
  before_action :check_owner_id, only: [:create]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def index
    @seats = Seat.all
  end

  def show
    @seat = Seat.find_by(id: params[:id])
    @owner = @seat.owner
    @record = Record.new
  end

  def new
    @seat = Seat.new
  end

  def edit
  end

  def create
    @seat = Seat.new(seat_params)
    if @seat.save
      redirect_to @seat
    else
      render 'new'
    end
  end

  def update
    if @seat.update(seat_params)
      redirect_to @seat
    else
      render 'edit'
    end
  end

  def destroy
    if @seat.destroy
      redirect_to seats_path
    end
  end

  private

    def set_seat
      @seat = Seat.find(params[:id])
    end

    def seat_params
      params.require(:seat).permit(:owner_id)
    end

    def record_not_found
      render plain: "404 Not Found", status: 404
    end

    def check_owner_id
      params = seat_params
      if User.find_by(id: params[:owner_id]).nil?
        render plain: "Must assign seat to existing user"
      end
    end

end
