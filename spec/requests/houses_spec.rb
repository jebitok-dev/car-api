require 'rails_helper'

RSpec.describe 'Houses API', type: :request do 
    let!(:houses) {create_list(:house, 10)}
    let(:house_id) {houses.first.id}

    describe 'GET /houses' do
        before {get '/houses'}

        it 'returns houses' do
            expect(json).not_to be_empty
            expect(json_size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    describe 'GET /houses/:id' do
        before {get "/houses/#{house_id}"}

        context 'when the record exists' do
            it 'returns the house' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(house_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exist' do 
            let(house_id) {100}

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do 
                expect(response.body).to match(/Couldn't find House/)
            end
        end
    end

    describe 'POST /houses' do
        let(:valid_attributes) {{title: 'Apartment', created_by: '1'}}

        context 'when the request is valid' do 
            before {post '/houses', params: valid_attributes}

            it 'creates a house' do
                expect(json['title']).to eq('Apartment')
            end

            it 'returns status code 201' do 
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do 
            before {post '/houses', params: {title: 'Foobar'}}

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do 
                expect(response.body)
                    .to match(/Validation failed: Created by can't be blank/)
            end
        end
    end

    describe 'PUT /houses/:id' do
        let(:valid_attributes) {{title: 'Flats'}}

        context 'when the record exists' do
            before {put "/houses/#{house_id}", params: valid_attributes}

            it 'updates the record' do 
                expect(response.body).to be_empty
            end

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end

    describe 'DELETE /houses/:id' do
        before {delete "/houses/#{house_id}"}

        it 'returns status code 204' do 
            expect(response).to have_http_status(204)
        end
    end
end
