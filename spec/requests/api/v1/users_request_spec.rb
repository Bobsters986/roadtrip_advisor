require 'rails_helper'

RSpec.describe 'Users API' do
  context '#create' do
    before do
      user_1 = User.create(email: 'john@fake.com', password: 'password', password_confirmation: 'password')
      user_2 = User.create(email: 'jim@fake.com', password: 'password2', password_confirmation: 'password2')
      user_3 = User.create(email: 'jake@fake.com', password: 'password3', password_confirmation: 'password3')
    end

    context 'when successful' do
      it 'creates a user' do
        expect(User.count).to eq(3)

        user_params = {
          email: 'bobby@fake.com',
          password: 'password4',
          password_confirmation: 'password4'
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/users', headers: headers, params: user_params, as: :json
        new_user = User.last

        expect(response).to have_http_status(201)

        user = JSON.parse(response.body, symbolize_names: true)

        expect(user[:data]).to be_a(Hash)
      end
    end
  end
end