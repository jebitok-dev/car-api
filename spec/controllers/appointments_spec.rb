require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  describe 'post a question route', type: :request do
    before(:all) do
      User.destroy_all
      User.create(name: 'sharon', email: 'sharon@gmail.com', password: '@1234$%8976', id: 1)
    end

    before do
      post '/appointments', params: {
        appointment: { username: 'foobar', model: 'MK7 Golf GTI', date: '3/8/2021', city: 'Nakuru', user_id: '1' }
      }
    end

    it 'returns the username' do
      expect(JSON.parse(response.body)['username']).to eq('foobar')
    end

    it 'returns the model' do
      expect(JSON.parse(response.body)['model']).to eq('MK7 Golf GTI')
    end

    it 'returns the date' do
      expect(JSON.parse(response.body)['date']).to eq('3/8/2021')
    end

    it 'returns the city' do
      expect(JSON.parse(response.body)['city']).to eq('Nakuru')
    end
  end
end
