class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
    @owner = User.find(@pet.owner_id)
  end

  def new
    @pet = Pet.new
    @users = User.all
  end

  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    redirect_to pets_path
  end

  def create
    @pet = Pet.new(pet_params)
    if @pet.save
      redirect_to pets_path
    else
      render :new
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :age, :image_url, :description, :owner_id)
  end
end
