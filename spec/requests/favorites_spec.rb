require 'rails_helper'

RSpec.describe 'Favorite API' do
    let!(:house) {create(:house)}
    let!(:favorites){create_list(:favorite, 20, house_id: house.id)}
    let(:house_id){house.id}
    let(:id){favorites.first.id}

    describe 'GET /houses/:house_id/favorites' do 
        before {get "/houses/#house_id/favorites"}

        context 'when house exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns all house items' do 
                expect(json.size).to eq(20)
            end
        end

        context 'when house does not exist' do
            let(:house_id) {0}

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' does
                expect(response.body).to match(/Couldn't find House/)
            end
        end
    end

    describe 'GET /houses/:house_id/favorites/:id' do
        before{get "/houses/#{house_id}/favorites/#{id}"}

        context 'when house favorite exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns a the favorite' do
                expect(json['id'].to eq(id))
            end
        end

        context 'when house favorite does not exist' do 
            let(:id) {0}

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find favorite/)
            end
        end
    end

    describe 'POST /houses/:todo_id/favorites' do 
        let(:valid_attributes) {{name: 'Apartments', done: false}}

        context 'when request attributes are valid' do 
            before {post "/houses/#{house_id}/favorites", params: valid_attributes}

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when an invalid request' do
            before {post "/houses/#{house_id}/favorites", params: {}}

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a failure message' do 
                expect(response.body).to match(/Validation failed: Name can't be blank/)
            end 
        end
    end

    describe 'PUT /houses/:house_id/favorites/:id' do
        let(:valid_attributes) {{name: 'Flats'}}

        before {put "/houses/#{house_id}/favorites/#{id}", params: valid_attributes}

        context 'when favorite exists' do
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end

            it 'updates the favorite' do
                updated_favorite = Favorite.find(id)
                expect(updated_favorite.name).to match(/Flats/)
            end
        end

        context 'when the item does not exist' do 
            let(:id) {0}

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found' do 
                expect(response.body).to match(/Couldn't find Favorite/)
            end
        end
    end

    describe 'DELETE /houses/:id' do
        before {delete "/houses/#{house_id}/favorites/#{id}"}

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end