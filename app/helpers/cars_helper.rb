module CarsHelper
  def cars_params
    params.require(:car).permit(:name, :model, :reviews, :price, :description)
  end
end
