require 'rails_helper'

RSpec.describe RoadTrip do
  describe "#initialize" do
    it "can create a road trip object from 3 different collections" do

      origin = "Denver,CO"
      destination = "Pueblo,CO"

      travel_time = "01:44:22"

      arrival_forecast = {
        datetime: "2021-03-07 21:00:00 -0700",
        temperature: 52.0,
        condition: "Sunny"
      }

      road_trip = RoadTrip.new(origin, destination, travel_time, arrival_forecast)

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.id).to eq(nil)
      expect(road_trip.start_city).to eq(origin)
      expect(road_trip.end_city).to eq(destination)
      expect(road_trip.travel_time).to eq(travel_time)
      expect(road_trip.weather_at_eta).to be_a(Hash)
      expect(road_trip.weather_at_eta[:datetime]).to eq(arrival_forecast[:datetime])
      expect(road_trip.weather_at_eta[:temperature]).to eq(arrival_forecast[:temperature])
      expect(road_trip.weather_at_eta[:condition]).to eq(arrival_forecast[:condition])
    end
  end
end