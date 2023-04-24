require 'rails_helper'

RSpec.describe 'Users API' do
  context '#create' do
    let!(:user_1) { User.create(email: 'john@fake.com', password: 'password', password_confirmation: 'password') }
    let!(:user_2) { User.create(email: 'jim@fake.com', password: 'password2', password_confirmation: 'password2') }
    let!(:user_3) { User.create(email: 'jake@fake.com', password: 'password3', password_confirmation: 'password3') }

    context 'when successful' do
      it 'creates a user and an api key for them' do
        expect(User.count).to eq(3)

        user_params = {
          email: 'bobby@fake.com',
          password: 'password4',
          password_confirmation: 'password4'
        }

        headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        post '/api/v1/users', headers: headers, params: user_params, as: :json
        new_user = User.last

        expect(response).to have_http_status(201)
        expect(User.count).to eq(4)

        user = JSON.parse(response.body, symbolize_names: true)

        expect(user[:data]).to be_a(Hash)
        expect(user[:data].keys).to eq([:id, :type, :attributes])
        expect(user[:data][:id]).to eq(new_user.id.to_s)
        expect(user[:data][:type]).to eq('user')
        expect(user[:data][:attributes].keys).to_not include(:password, :password_confirmation)
        expect(user[:data][:attributes].keys).to eq([:email, :api_key])
        expect(user[:data][:attributes][:email]).to eq(new_user.email)
        expect(user[:data][:attributes][:api_key]).to eq(new_user.api_key)
        expect(user[:data][:attributes][:api_key]).to_not eq(user_1.api_key)
        expect(user[:data][:attributes][:api_key]).to_not eq(user_2.api_key)
        expect(user[:data][:attributes][:api_key]).to_not eq(user_3.api_key)
      end
    end

    context 'when unsuccessful' do
      it 'returns an error if email is already taken' do
        expect(User.count).to eq(3)

        duplicate_params = {
          email: 'john@fake.com',
          password: 'password4',
          password_confirmation: 'password4'
        }

        headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        post '/api/v1/users', headers: headers, params: duplicate_params, as: :json
        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)
        expect(User.count).to eq(3)
        expect(parsed[:errors]).to eq('Email has already been taken')
      end

      it 'returns an error if passwords do not match' do
        expect(User.count).to eq(3)

        mismatched_params = {
          email: 'bogus@fake.com',
          password: 'password4',
          password_confirmation: 'password5'
        }

        headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        post '/api/v1/users', headers: headers, params: mismatched_params, as: :json
        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)
        expect(User.count).to eq(3)
        expect(parsed[:errors]).to eq("Password confirmation doesn't match Password, Password confirmation doesn't match Password")
      end

      it 'returns an error if email or password are missing' do
        expect(User.count).to eq(3)

        missing_params = {
          email: ' ',
          password: ' ',
          password_confirmation: ' '
        }

        headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        post '/api/v1/users', headers: headers, params: missing_params, as: :json
        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(400)
        expect(User.count).to eq(3)
        expect(parsed[:errors]).to eq("Email can't be blank, Password can't be blank")
      end
    end
  end
end