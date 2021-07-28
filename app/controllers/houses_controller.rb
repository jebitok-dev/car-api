class HousesController < ApplicationController
    before_action :set_house, only: [:show, :update, :destroy]

    def index 
        @houses = House.all
        json_response(@houses)
    end

    def create
        @house = House.create!(house_params)
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
        params.permit(:title, :created_by)
    end

    def set_house
        @house = House.find(params[:id])
    end
end
