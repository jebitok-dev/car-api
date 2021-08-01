class HousesController < ApplicationController
  include HousesHelper
  def index
    @houses = House.all
    render json: @houses
  end

  def new 
    @house = House.new
  end

  def create
    @house = House.new(house_params)
    @house.save
  end
end
