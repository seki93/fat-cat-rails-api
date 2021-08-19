require 'rails_helper'

RSpec.describe "Api::V1::Authentication", type: :request do

  describe 'POST /authentication' do
    let(:user) { FactoryBot.create(:user, username: 'Doe', password: 'password') }

    it 'authenticates the user' do
      post '/api/v1/authenticate', params: { username: user.username, password: 'password' }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to eq({
                                                  'token' => 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.eU5RmofDjsTBkmYFZmccyBoKtLS6Rqebe1wnHDtyzto'
                                              }
                                           )
    end

    it 'returns error when username is missing' do
      post '/api/v1/authenticate', params: { password: 'password' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to eq({
                                                  'error' => 'param is missing or the value is empty: username'
                                              })
    end

    it 'returns error when password is missing' do
      post '/api/v1/authenticate', params: { username: user.username }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to eq({
                                                  'error' => 'param is missing or the value is empty: password'
                                              })
    end

    it 'returns error when password is incorrect' do
      post '/api/v1/authenticate', params: { username: user.username, password: 'password123' }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
