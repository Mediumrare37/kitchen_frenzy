class KitchensController < ApplicationController

  def new
    @kitchen = Kitchen.new
    authorize @kitchen
  end

  def create
    @kitchen = Kitchen.new(kitchen_params)
    @kitchen.user = current_user
    authorize @kitchen
  end


  def show
    authorize @kitchen
  end

  def kitchen_params
    params.require(:kitchen).permit(:name)
  end

  def edit
    authorize @kitchen
  end

  def update
    authorize @kitchen
  end

  def destroy
    authorize @kitchen
  end

  def index
    @kitchens = policy_scope(Kitchen)
  end
end
