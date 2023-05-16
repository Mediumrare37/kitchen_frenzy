class KitchensController < ApplicationController
  def index
  end

  def show
    @kitchen = Kitchen.find(params[:id])
  end

  private

  def kitchen_params
    params.require(:kitchen).permit(:details, :location, :price_per_day)
  end
end
