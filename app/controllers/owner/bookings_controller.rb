class Owner::BookingsController < ApplicationController
  def index
    @bookings = current_user.bookings_as_owner
    policy_scope([:owner, Booking])
  end

  # no need for this create method as booking only created on user side
  # def create
  #   @kitchen = Kitchen.find(params[:kitchen_id])
  #   @booking = @kitchen.bookings.build(booking_params)
  #   if @booking.save
  #     redirect_to confirmation_path
  #   else
  #     render 'Admin error'
  #     puts "Please contact your admin"
  #   end
  # end

  def update
    @booking = Booking.find(params[:id])
    authorize([:owner, @booking])
    if @booking.update(booking_params)
      redirect_to owner_bookings_path
    else
      #Unsure what to write here
      render 'Admin error'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:status, :start_date, :end_date)
  end
end
