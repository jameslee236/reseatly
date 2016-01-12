class SeatsController < ApplicationController
  before_action :set_seat, only: [:show, :edit, :update, :destroy]
  before_action :check_owner_id, only: [:create]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @seats = Seat.all
  end

  def reseat
    @seats = Seat.all
    @users = User.all.order('total_hours DESC')
    @new_seats = find_gainers
    @lose_seats = find_losers
    render 'reseat'
  end

  def reset
    @seats = Seat.all
    @seats.update_all(owner_id: 0)
    keepers = find_seat_keepers
    counter = 0
    @seats.each do |seat|
      seat.owner_id = keepers[counter].id
      counter += 1
      seat.save
    end
    redirect_to home_path
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

  def find_old_seats
    seats = Seat.all
    old_seats_id = []
    old = []
    seats.each do |seat|
      if seat.owner_id > 0
        old_seats_id << seat.owner_id
      end
    end
    old_seats_id.each do |id|
      old << User.find(id)
    end
    return old
  end

  def find_seat_keepers
    users = User.all.order('total_hours DESC')
    users_array = []
      users.each do |user|
       users_array << user
      end
    seat_count = Seat.all.count
    new_seat_users = []
    seat_count.times {new_seat_users << users_array.shift}
    return new_seat_users
  end

  def find_gainers
    new = find_seat_keepers
    old = find_old_seats
    new - old
  end

  def find_losers
    new = find_seat_keepers
    old = find_old_seats
    old - new
  end

end
