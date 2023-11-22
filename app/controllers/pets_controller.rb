class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    find_pet
    owner_id
  end

  def new
    @pet = Pet.new
    @users = User.all
  end

  def destroy
    find_pet
    @pet.destroy
    redirect_to pets_path
  end

  def create
    @pet = Pet.new(pet_params)
    owner_id

    if @pet.save
      redirect_to pets_path
    else
      render :new
    end
  end

  def edit
    find_pet
    @users = User.all
  end

  def update
    find_pet
    @pet.update(pet_params)
    redirect_to pets_path
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :age, :image_url, :description, :owner_id)
  end

  # method to find pet by id
  def find_pet
    @pet = Pet.find(params[:id])
  end

  def owner_id
    @owner = User.find(@pet.owner_id)
  end
end
