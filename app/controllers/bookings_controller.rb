class BookingsController < ApplicationController
  before_action :find_booking, only: %i[show edit update destroy]

  def index
    @bookings = Booking.all
  end

  def show
    pet_id
    user_id
  end

  def new
    @booking = Booking.new
    @pets = Pet.all
  end

  def create
    @booking = Booking.new(booking_params)
    pet_id
    user_id

    if @booking.save
      redirect_to bookings_path
    else
      render :new
    end
  end

  def edit
    @pets = Pet.all
  end

  def update
    @booking.update(booking_params)
    redirect_to bookings_path
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :pet_id, :user_id)
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end
end
