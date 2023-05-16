class KitchensController < ApplicationController
  def index
  end

  def show
    @kitchen = Kitchen.find(params[:id])
  end

  def new
    @kitchen = Kitchen.new
    @kitchen = Kitchen.new(params[kitchen_params])
  end

  private

  def kitchen_params
    params.require(:kitchen).permit(:details, :location, :price_per_day)
  end
end
