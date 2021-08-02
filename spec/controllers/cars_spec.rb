require 'rails_helper'

RSpec.describe CarsController, type: :controller do
    describe 'GET index' do
        before(:all) do
          Car.destroy_all
        end
    
        it 'assigns @cars' do
          car = Car.create(name: '2020 TESLA MODEL', model: 'WHITE Y', reviews: '4', price: '$65784')
          get :index
          expect(assigns(:cars)).to eq([car])
        end
    end
end
