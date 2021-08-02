class CarsController < ApplicationController
        include CarsHelper
        def index
          @cars = Car.all
          render json: @cars
        end
      
        def new 
          @car = Car.new
        end
      
        def create
          @car = Car.new(car_params)
          @car.save
        end      
end
