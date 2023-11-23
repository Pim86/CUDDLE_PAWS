class PetsController < ApplicationController
  before_action :find_pet, only: %i[show edit update destroy]

  def index
    @pets = Pet.all
  end

  def show
    @booking = Booking.new
    @user = User.find(@pet.owner_id)
  end

  def new
    @pet = Pet.new
    @users = User.all
  end

  def destroy
    @pet.destroy
    redirect_to pets_path
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.owner = current_user

    if @pet.save
      redirect_to pets_path
    else
      render :new
    end
  end

  def edit
    @users = User.all
  end

  def update
    @pet.update(pet_params)
    redirect_to pets_path
  end

  def cats
    @pets = Pet.where(species: "cat")
  end

  def dogs
    @pets = Pet.where(species: "dog")
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :age, :image_url, :description)
  end

  # method to find pet by id
  def find_pet
    @pet = Pet.find(params[:id])
  end
end
