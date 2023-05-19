class KitchensController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def index
    # @kitchens = Kitchen.all
    @kitchens = policy_scope(Kitchen)

    # Map display
    @markers = @kitchens.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end

  def show
    @booking = Booking.new
    @kitchen = Kitchen.find(params[:id])
    @reviews = @kitchen.reviews
    authorize @kitchen
  end

  def new
    @kitchen = Kitchen.new
    authorize @kitchen
    @kitchens = current_user.kitchens
  end

  def create
    @kitchen = Kitchen.new(kitchen_params)
    @kitchen.user = current_user
    if @kitchen.save
      redirect_to kitchen_path(@kitchen)
    else
      render :new, status: :unprocessable_entity
    end
    # Authorization code
    authorize @kitchen
  end

  def edit
    @kitchen = Kitchen.find(params[:id])
    authorize @kitchen
  end

  def update
    authorize @kitchen

    if @kitchen.update(kitchen_params)
      redirect_to new_kitchen_path, notice: 'Kitchen was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitchen = Kitchen.find(params[:id])
    authorize @kitchen
    @kitchen.destroy
    redirect_to kitchens_path, notice: 'Kitchen was successfully deleted.'
  end

  private

  def kitchen_params
    params.require(:kitchen).permit(:title, :details, :location, :price_per_day)
  end
end
