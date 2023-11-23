class BookingsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :find_booking, only: %i[show edit update destroy]

  def index
    @bookings = Booking.where(user_id: current_user)
  end

  def show
  end

  def new
    @booking = Booking.new
    @pet = Pet.find(params[:pet_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @pet = Pet.find(params[:pet_id])
    @booking.pet = @pet
    if @booking.save
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to bookings_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date_time, :end_date_time, :pet_id, :user_id)
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end
end
