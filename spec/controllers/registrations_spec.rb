require "rails_helper"

RSpec.describe RegistrationsController, type: :controller do
    describe 'post a question route', type: :request do
        before(:all) do
          User.destroy_all
        end
    
        before do
          post '/registrations', params: {
            user: { name: 'foobar', email: 'foobar@gmail.com', password: '123456', password_confirmation: '123456' }
          }
        end
    
        it 'returns the name' do
          expect(JSON.parse(response.body)['user']['name']).to eq('foobar')
        end
    
        it 'returns the email' do
          expect(JSON.parse(response.body)['user']['email']).to eq('foobar@gmail.com')
        end
    end
end