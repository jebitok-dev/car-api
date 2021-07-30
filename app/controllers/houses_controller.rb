class HousesController < ApplicationController
  before_action :set_house, only: %i[show update destroy]

  def index
    @houses = current_user.houses
    json_response(@houses)
  end

  def create
    @house = current_user.houses.create!(house_params)
    json_response(@house, :created)
  end

  def show
    json_response(@house)
  end

  def update
    @house.update(house_params)
    head :no_content
  end

  def destroy
    @house.destroy
    head :no_content
  end

  private

  def house_params
    params.permit(:title)
  end

  def set_house
    @house = House.find(params[:id])
  end
end
