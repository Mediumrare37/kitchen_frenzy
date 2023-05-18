class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @kitchens = Kitchen.all
    @markers = @kitchens.geocoded.map do |kitchen|
      {
        lat: kitchen.latitude,
        lng: kitchen.longitude
      }
    end
  end
end
