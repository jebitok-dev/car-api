require 'rails_helper'

RSpec.describe 'Cars', type: :request do
  # initialize test data
  let(:user) { create(:user) }

  let!(:cars) { create_list(:car, 10) }
  let!(:car) { create(:car) }

  let(:car_id) { cars.first.id }

  # authorize request
  let(:headers) { valid_headers }

  describe 'GET /cars' do
    before { get '/cars/', params: {}, headers: headers }

    it 'returns cars' do
      expect(json).to be_truthy
      expect(json).not_to be_empty
      expect(json.size).to eq(11)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /cars/:id' do
    before { get "/cars/#{car_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the car' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(car_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:car_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/"message":"Couldn't find Car with 'id'=#{car_id}/)
      end
    end
  end

  describe 'POST /cars' do
    # valid payload
    let(:valid_attributes) do
      { price: '36000', model: 'VW Golf GTI Clubsport', reviews: 'fast car', picture: 'golfmk.png',
        name: 'Golf' }.to_json
    end

    context 'when the request is valid' do
      before { post '/cars', params: valid_attributes, headers: headers }

      it 'creates a car' do
        expect(json['model']).to eq('VW Golf GTI Clubsport')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid (only Model is present)' do
      before { post '/cars', params: { model: 'VW Golf GTI Clubsport' }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/"message":"Validation failed: Picture can't be blank, Name can't be blank, Reviews can't be blank, Price can't be blank/)
      end
    end

    context 'when the request is invalid' do
      before { post '/cars', params: {}.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/"message":"Validation failed: Picture can't be blank, Name can't be blank, Model can't be blank, Reviews can't be blank, Price can't be blank/)
      end
    end

    context 'when the request is invalid (only Picture is present)' do
      before { post '/cars', params: { picture: 'golf.png' }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/"message":"Validation failed: Name can't be blank, Model can't be blank, Reviews can't be blank, Price can't be blank/)
      end
    end

    context 'when the request is invalid (only Price is present)' do
      before { post '/cars', params: { price: 'url car' }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/"message":"Validation failed: Picture can't be blank, Name can't be blank, Model can't be blank, Reviews can't be blank/)
      end
    end

    context 'when the request is invalid (only Name is present)' do
      before { post '/cars', params: { name: 'golf' }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/"message":"Validation failed: Picture can't be blank, Model can't be blank, Reviews can't be blank, Price can't be blank/)
      end
    end
  end

  describe 'PUT /cars/:id' do
    let(:valid_attributes) { { reviews: 'Shopping Car' }.to_json }

    context 'when the record exists' do
      before { put "/cars/#{car_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /cars/:id' do
    before { delete "/cars/#{car_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
