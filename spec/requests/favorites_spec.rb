require 'rails_helper'

RSpec.describe 'Favorites', type: :request do
  let!(:user) { create(:user) }
  let!(:car) { create(:car) }
  let!(:favorites) { create_list(:favorite, 20, car_id: car_id, user_id: user_id) }
  let!(:id) { favorites.first.id }
  let!(:user_id) { user_id }
  let(:car_id) { car_id }
  let(:headers) { valid_headers }

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

  describe 'POST /users/:user_id/favorites' do
    let(:valid_attributes) { { car_id: car_id.to_s }.to_json }

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/favorites", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/favorites", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/message":"Validation failed: Car must exist"/)
      end
    end
  end

  describe 'PUT /users/:user_id/favorites/:id' do
    let(:valid_attributes) { { car_id: car_id.to_s }.to_json }

    before { put "/users/#{user_id}/favorites/#{id}", params: valid_attributes, headers: headers }

    context 'when favourite exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the favourite' do
        updated_favourite = Favourite.find(id)
        expect(updated_favourite.car_id).to match(car_id)
      end
    end

    context 'when the favourite does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/"message":"Couldn't find Favourite/)
      end
    end
  end

  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}/favorites/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
