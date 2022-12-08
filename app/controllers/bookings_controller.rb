class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  def show; end

  def new
    @room = Room.find(params[:room_id])
    @booking = Booking.new
  end

  def create
    @room = Room.find(params[:room_id])
    @booking = Booking.new(booking_params)

    @booking.start_date_time = local_to_utc(params[:booking][:start_date_time])
    @booking.end_date_time = local_to_utc(params[:booking][:end_date_time])

    @all_info = Booking.where(room_id: @room.id).select("start_date_time, end_date_time")
    arr = []
    @all_info.each do |val|
      temp = []
      temp.push(val[:start_date_time], val[:end_date_time])
      arr.push(temp)
      # puts val[:start_date_time]
      # byebug
    end
    puts arr
    byebug

    if @all_info.empty?
      if @booking.save
        redirect_to room_booking_path(@room, @booking)
      else
        render "new"
      end
    else
      if @booking.save
        redirect_to room_booking_path(@room, @booking)
      else
        render "new"
      end
    end
  end

  private

  def booking_params
    @room = Room.find(params[:room_id])
    params.require(:booking)
          .permit(:description, :start_date_time, :end_date_time)
          .merge(user_id: current_user.id, room_id: @room.id)
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def local_to_utc(time)
    to_utc = time.split("T")[1].in_time_zone.utc - 5.hours - 45.minutes
    to_utc.to_s.split(" ").join("T")[0..-8]
  end
end
