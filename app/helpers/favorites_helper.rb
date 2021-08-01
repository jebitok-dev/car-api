module FavoritesHelper
    def favorites_params
      params.require(:favorite).permit(:name, :model, :date, :city, :user_id)
    end
end
