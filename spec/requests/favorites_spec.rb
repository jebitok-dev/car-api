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

        context 'when todo item exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

        end
    end

end