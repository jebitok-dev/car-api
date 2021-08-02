require 'rails_helper'

RSpec.describe Car, type: :model do
  before(:all) do
    Car.destroy_all
    Car.create(name: '2020 TESLA MODEL', model: 'WHITE Y', reviews: '4', price: '$65784')
  end
  it 'is valid with valid attributes' do
    expect(Car.all.count).to be_eql 1
  end
end
