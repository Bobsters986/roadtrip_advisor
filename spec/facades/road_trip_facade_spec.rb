require 'rails_helper'

describe RoadTripFacade do
  describe "#forecast_at_destination" do
    it "returns full forecast for destination" do
      VCR.use_cassette("la_road_trip_facade_forecast") do
        origin = "Denver,CO"
        destination = "Los Angeles,CA"
        road_trip = RoadTripFacade.new(origin, destination).forecast_at_destination

        expect(road_trip).to be_a(Hash)
        expect(road_trip[:location].size).to eq(8) 
        expect(road_trip[:location]).to have_key(:name)
        expect(road_trip[:location][:name]).to be_a(String)
        expect(road_trip[:location][:name]).to eq("Los Angeles")

        expect(road_trip[:current]).to be_a(Hash)
        expect(road_trip[:current].size).to eq(23)

        expect(road_trip[:forecast]).to be_a(Hash)
        expect(road_trip[:forecast][:forecastday]).to be_an(Array)
        expect(road_trip[:forecast][:forecastday].size).to eq(5) #5 days of forecast

        expect(road_trip[:forecast][:forecastday][0].size).to eq(5)
        expect(road_trip[:forecast][:forecastday][0][:hour]).to be_an(Array)
        expect(road_trip[:forecast][:forecastday][0][:hour].size).to eq(24) #24 hours of forecast
      end
    end
  end
end