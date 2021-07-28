class FavoritesController < ApplicationController
    before_action :set_house
    before_action :set_house_favorite, only: [:show, :update, :destroy]

    def index
        json_response(@house.favorites)
    end

    def show
        json_response(@favorites)
    end

    def create
        @house.favorites.create!(favorite_params)
        json_response(@house, :created)
    end

    def update
        @favorite.update(favorite_params)
        head :no_content
    end

    def destroy
        @favorite.destroy
        head :no_content
    end

    private

    def favorite_params
        params.permit(:name, :done)
    end

    def set_house
        @house = House.find(params[:house_id])
    end

    def set_house_favorite
        @favorite = @house.favorites.find_by!(id: params[:id]) if @house
    end
end
