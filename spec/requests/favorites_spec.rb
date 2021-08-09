require 'rails_helper'

RSpec.describe 'Favorites API', type: :request do
  let!(:user) { create(:user) }
  let!(:car) { create(:car) }
  let!(:favorites) { create_list(:favorite, 20, car_id: car.id, user_id: user.id) }
  let(:id) { favorites.first.id }
  let!(:user_id) { user.id }
  let(:car_id) { car.id }
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

  # Test suite for GET /users/:user_id/favorites/:id
  describe 'GET /users/:user_id/favorites/:id' do
    before { get "/users/#{user_id}/favorites/#{id}", params: {}, headers: headers }

    context 'when user favorite exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the favorite' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when user favorite does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Favorite/)
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

    context 'when favorite exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the favorite' do
        updated_favorite = Favorite.find(id)
        expect(updated_favorite.car_id).to match(car_id)
      end
    end

    context 'when the favorite does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/"message":"Couldn't find Favorite/)
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
