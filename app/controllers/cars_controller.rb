class CarsController < ApplicationController
  before_action :set_car, only: %i[show update destroy]

  def index
    @cars = Car.all
    json_response(@cars)
  end

  def create
    @car = current_user.cars.create!(car_params)
    json_response(@car, :created)
  end

  def show
    json_response(@car)
  end

  def update
    @car.update(car_params)
    head :no_content
  end

  def destroy
    @car.destroy
    head :no_content
  end

  private

  def car_params
    params.permit(:name, :model, :reviews, :price, :picture)
  end

  def set_car
    @car = Car.find(params[:id])
  end
end
