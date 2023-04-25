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

  describe "#days_of_travel" do #if less than the next 24 hour increment, rounds down
    it "returns days of travel, NY to LA" do
      VCR.use_cassette("days_of_travel/la_road_trip_facade_days_of_travel") do
        origin = "New York,NY"
        destination = "Los Angeles,CA"
        travel_time = MapquestService.get_travel_info(origin, destination)[:route][:formattedTime]
        expect(travel_time).to eq("40:16:11")

        road_trip_days = RoadTripFacade.new(origin, destination).days_of_travel(travel_time)

        expect(road_trip_days).to be_an(Integer)
        expect(road_trip_days).to eq(1)
      end
    end

    it "returns days of travel, New York,NY to Panama City,Panama" do
      VCR.use_cassette("days_of_travel/panama_road_trip_facade_days_of_travel") do
        origin = "New York,NY"
        destination = "Panama City,Panama"
        travel_time = MapquestService.get_travel_info(origin, destination)[:route][:formattedTime]
        expect(travel_time).to eq("80:30:17")

        road_trip_days = RoadTripFacade.new(origin, destination).days_of_travel(travel_time)

        expect(road_trip_days).to be_an(Integer)
        expect(road_trip_days).to eq(3)
      end
    end

    it "returns days of travel, Denver,CO to Pueblo,CO" do #if less than 24 hours, days of travel is 0
      VCR.use_cassette("days_of_travel/pueblo_road_trip_facade_days_of_travel") do
        origin = "Denver,CO"
        destination = "Pueblo,CO"
        travel_time = MapquestService.get_travel_info(origin, destination)[:route][:formattedTime]
        expect(travel_time).to eq("01:43:10")

        road_trip_days = RoadTripFacade.new(origin, destination).days_of_travel(travel_time)

        expect(road_trip_days).to be_an(Integer)
        expect(road_trip_days).to eq(0)
      end
    end
  end
end