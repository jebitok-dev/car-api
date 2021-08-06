require 'rails_helper'

RSpec.describe 'Favorites', type: :request do
    let!(:user) {create(:user)}
    let!(:car){create(:car)}
    let!(:favorites){create_list(:favorite, 20, car_id: car_id, user_id: user_id)}
    let!(:id){favorites.first.id}
    let!(:user_id){user_id}
    let(:car_id){car_id}
    let(:headers){valid_headers}
    
    describe 'GET /users/:user_id/favorites' do
        before { get "/users/#{user_id}/favorites", params: {}, headers: headers }

        context 'when user exists' do
        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end

        it 'returns all user favorites' do
            expect(json.size).to eq(20)
        end
        end

        context 'when user does not exist' do
        let(:user_id) { 0 }

        it 'returns status code 404' do
            expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find User/)
        end
    end
end