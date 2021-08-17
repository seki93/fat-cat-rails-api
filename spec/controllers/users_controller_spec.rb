require 'rails_helper'

describe 'Users API', type: :request do
  describe 'POST /users' do
    it 'create a new user' do
      expect{
        post '/api/v1/users', params: { user: { username: 'John', password: 'password'} }
      }.to change { User.count }.from(0).to(1)

      expect(User.first.username).to eq('John')
    end

    it 'return unprocessable_entity - 422 when password is too short' do
      post '/api/v1/users', params: { user: { username: 'John', password: '12'} }

      expect(response.code).to eq('422')
      expect(User.all.count).to eq(0)
    end
  end
end
