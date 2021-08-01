module HousesHelper
    def houses_params
      params.require(:house).permit(:name, :model, :reviews, :price, :description)
    end
end
