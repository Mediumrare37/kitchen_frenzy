class KitchensController < ApplicationController
  def index
    @kitchens = Kitchen.all
    @kitchens = policy_scope(Kitchen)
  end

  def show
    @booking = Booking.new
    @kitchen = Kitchen.find(params[:id])
    authorize @kitchen
  end

  def new
    @kitchen = Kitchen.new
    authorize @kitchen
  end

  def create
    @kitchen = Kitchen.new(kitchen_params)
    if @kitchen.save
      redirect_to kitchen_path(@kitchen)
    else
      render :new, status: :unprocessable_entity
    end
    # Authorization code
    @kitchen.user = current_user
    authorize @kitchen
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

  private

  def kitchen_params
    params.require(:kitchen).permit(:title, :details, :location, :price_per_day)
  end
end
