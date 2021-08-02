require 'rails_helper'

RSpec.describe CarsController, type: :controller do
  describe 'GET index' do
    before(:all) do
      Car.destroy_all
    end

    it 'assigns @cars' do
      car = Car.create(name: 'Volkswagen', model: 'MK7 Golf GTI', reviews: '4', price: '$34,915')
      get :index
      expect(assigns(:cars)).to eq([car])
    end
  end
end
