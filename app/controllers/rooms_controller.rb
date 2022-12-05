class RoomsController < ApplicationController
  before_action :find_room, only: %i[show edit update destroy]

  def index
    @book = Booking.where(room_id: nil)
    # byebug

    @rooms = if @book.empty?
              #  Room.joins('FULL OUTER JOIN bookings ON rooms.id = bookings.room_id').select('*')
             Room.left_joins(:bookings).select("*")
             #  Room.all
             else
               Room.joins(:bookings).select('*')
             end
  end

  def show; end

  def new
    @room = Room.new
  end

  def edit; end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to @room
    else
      render 'new'
    end
  end

  def update
    if @room.update(room_params)
      redirect_to @room
    else
      render 'edit'
    end
  end

  def destroy
    @room.destroy

    redirect_to rooms_path
  end

  private

  def room_params
    params.require(:room).permit(:name, :floor_number, :capacity, :room_image)
  end

  def find_room
    @room = Room.find(params[:id])
    session[:room_id] = @room.id
  end
end
