class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @room = Room.find(params[:room_id])
    @booking = Booking.new
  end

  def create
    @room = Room.find(params[:room_id])
    @booking = @room.bookings.new(booking_params)
    @meeting_date_time = @room.bookings.select('start_date_time, end_date_time')

    # base case:
    if @meeting_date_time.empty?
      @booking.save
      redirect_to room_booking_path(@room, @booking)
    else
      flag = true
      @meeting_date_time.each do |val|
        if @booking.start_date_time > val.start_date_time && @booking.start_date_time < val.end_date_time
          flag = false
          break
        end
        if @booking.end_date_time > val.start_date_time && @booking.start_date_time < val.end_date_time
          flag = false
          break
        end
      end
      if flag == false
        @flag = false
        render 'new'
        return
      end
      @booking.save
    end
    redirect_to room_booking_path(@room, @booking)
  end

  private

  def booking_params
    @room = Room.find(params[:room_id])
    params.require(:booking)
          .permit(:description, :start_date_time, :end_date_time)
          .merge(user_id: current_user.id, room_id: @room.id)
  end
end
