class PagesController < ApplicationController
  def home
    @kitchens = Kitchen.all
  end
end
