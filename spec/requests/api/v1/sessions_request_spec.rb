require 'rails_helper'

RSpec.describe 'Sessions Login API' do
  context '#create' do
    let!(:user_1) { User.create(email: 'billy@fake.com', password: 'password1') }
    let!(:user_2) { User.create(email: 'johnny@fake.com', password: 'password2') }

    context 'when successful' do
      it 'returns the user email and their api key' do
        login_params = { email: 'billy@fake.com', password: 'password1' }
        headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        post '/api/v1/sessions', headers: headers, params: login_params, as: :json

        user = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to have_http_status(200)
        expect(user[:data]).to be_a(Hash)
        expect(user[:data].keys).to eq([:id, :type, :attributes])
        expect(user[:data][:id]).to eq(user_1.id.to_s)
        expect(user[:data][:type]).to eq('user')
        expect(user[:data][:attributes].keys).to_not include(:password)
        expect(user[:data][:attributes].keys).to eq([:email, :api_key])
        expect(user[:data][:attributes][:email]).to eq(user_1.email)
        expect(user[:data][:attributes][:api_key]).to eq(user_1.api_key)
        expect(user[:data][:attributes][:api_key]).to_not eq(user_2.api_key)
      end
    end

    context 'when unsuccessful' do
      it 'returns an error if email is incorrect' do
        wrong_email_params = { email: 'sarah@fake.com', password: 'password1' }
        headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        post '/api/v1/sessions', headers: headers, params: wrong_email_params, as: :json

        parsed = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to have_http_status(401)
        expect(parsed[:errors]).to eq('Invalid email or password')
      end

      it 'returns the same error if password is incorrect' do
        wrong_password_params = { email: 'billy@fake.com', password: 'password2' }
        headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        post '/api/v1/sessions', headers: headers, params: wrong_password_params, as: :json

        parsed = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to have_http_status(401)
        expect(parsed[:errors]).to eq('Invalid email or password')
      end
    end
  end
end