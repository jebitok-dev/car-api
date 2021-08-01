class FavoritesController < ApplicationController
  before_action :verify_authenticity_token
  include FavoritesHelper

  def index
    @favorites = Favorite.all
    render json: @favorites
  end

  def new
    @favorite = Favorite.new
  end

  def create
    @favorite = Favorite.new(favorite_params)
    @favorite.save

    render json: {success: 'A favorite was successfully added!'}
  end
end
