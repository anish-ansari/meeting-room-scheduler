class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_booking, only: %i[show edit update destroy]

  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  def show; end

  def new
    @booking = Booking.new
  end

  def edit; end

  def create
    @booking = Booking.new(booking_params)
    # hour = params[:booking][:start_date_time].match(/(?<=T)\d+(?=:)/)
    # minure = params[:booking][:start_date_time].match(/(?<=:)\d+/)
    start_local_to_utc = params[:booking][:start_date_time].split("T")[1].in_time_zone.utc - 5.hours - 45.minutes
    start_utc_formatting = start_local_to_utc.to_s.split(" ").join("T")[0..-8]
    @booking.start_date_time = start_utc_formatting

    end_local_to_utc = params[:booking][:end_date_time].split("T")[1].in_time_zone.utc - 5.hours - 45.minutes
    end_utc_formatting = end_local_to_utc.to_s.split(" ").join("T")[0..-8]
    @booking.end_date_time = end_utc_formatting
    # byebug

    if @booking.save
      redirect_to @booking
      session.delete(:room_id)
    else
      render "new"
    end
  end

  def update; end

  def destroy; end

  private

  def booking_params
    params.require(:booking)
          .permit(:description, :start_date_time, :end_date_time)
          .merge(user_id: current_user.id, room_id: session[:room_id])
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end
end
