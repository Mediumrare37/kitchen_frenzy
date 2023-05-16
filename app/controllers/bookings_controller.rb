class BookingsController < ApplicationController
  def create
    @kitchen = kitchen.find(params[:kitchen_id])
    @booking = @kitchen.bookings.build(booking_params)
    if @booking.save
      #task: If a successful booking creating, re-drirect to the confirmation page.
    else
      #render an error page message.
    end
  end

  def index
    @bookings = Booking.where(chef_id: current_chef.id).order(start_date: :desc)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :guests)
  end

end
