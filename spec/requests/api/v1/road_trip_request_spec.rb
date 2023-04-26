require 'rails_helper'

RSpec.describe 'Road Trip API' do
  context "#create" do
    context "when successful" do
      it "sends a road trip object, IF the user sends a valid API key" do
        VCR.use_cassette("road_trip_den_to_la") do
          user = User.create!(email: "bob@fake.com", password: "password")

          road_trip_params = {
            origin: "Denver,CO",
            destination: "Los Angeles,CA",
            api_key: user.api_key
          }

          headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

          post '/api/v1/road_trip', headers: headers, params: road_trip_params, as: :json

          expect(response).to have_http_status(201)

          road_trip = JSON.parse(response.body, symbolize_names: true)

          expect(road_trip[:data]).to be_a(Hash)
          expect(road_trip[:data].keys).to eq([:id, :type, :attributes])
          expect(road_trip[:data][:id]).to eq(nil)
          expect(road_trip[:data][:type]).to eq("road_trip")
          expect(road_trip[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
          expect(road_trip[:data][:attributes][:start_city]).to eq("Denver,CO")
          expect(road_trip[:data][:attributes][:end_city]).to eq("Los Angeles,CA")
          expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
          expect(road_trip[:data][:attributes][:travel_time]).to eq("14:31:28")
          expect(road_trip[:data][:attributes][:weather_at_eta].keys).to eq([:datetime, :temperature, :condition])
          expect(road_trip[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
          expect(road_trip[:data][:attributes][:weather_at_eta][:datetime]).to eq("2023-04-26 10:00")
          expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
          expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to eq(70.0)
          expect(road_trip[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
          expect(road_trip[:data][:attributes][:weather_at_eta][:condition]).to eq("Sunny")
        end
      end

      it "still sends a road trip object, IF the user sends a valid API key, and the trip is impossible" do
        VCR.use_cassette("impossible_road_trip_den_to_london") do
          user_1 = User.create!(email: "Jill@fake.com", password: "password")

          road_trip_params = {
            origin: "Denver,CO",
            destination: "London,UK",
            api_key: user_1.api_key
          }

          headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

          post '/api/v1/road_trip', headers: headers, params: road_trip_params, as: :json

          expect(response).to have_http_status(201)

          road_trip = JSON.parse(response.body, symbolize_names: true)

          expect(road_trip[:data]).to be_a(Hash)
          expect(road_trip[:data].keys).to eq([:id, :type, :attributes])
          expect(road_trip[:data][:id]).to eq(nil)
          expect(road_trip[:data][:type]).to eq("road_trip")
          expect(road_trip[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
          expect(road_trip[:data][:attributes][:start_city]).to eq("Denver,CO")
          expect(road_trip[:data][:attributes][:end_city]).to eq("London,UK")
          expect(road_trip[:data][:attributes][:travel_time]).to eq("Impossible Route")
          expect(road_trip[:data][:attributes][:weather_at_eta]).to eq({})
        end
      end
    end
  end
end