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

  describe "#get_arrival_time" do
    it "returns arrival time, NY to LA" do
      VCR.use_cassette("arrival_time/la_road_trip_facade_arrival_time") do
        origin = "New York,NY"
        destination = "Los Angeles,CA"
        travel_time = MapquestService.get_travel_info(origin, destination)[:route][:formattedTime]
        expect(travel_time).to eq("40:18:25")

        road_trip_arrival_time = RoadTripFacade.new(origin, destination).get_arrival_time(travel_time)

        expect(road_trip_arrival_time).to be_a(Time)
        # expect(road_trip_arrival_time.to_s).to eq("2023-04-27 10:20:43 -0600") ran at 6:02pm on 4/25/2023
      end
    end

    it "returns arrival time, New York,NY to Panama City,Panama" do
      VCR.use_cassette("arrival_time/panama_road_trip_facade_arrival_time") do
        origin = "New York,NY"
        destination = "Panama City,Panama"
        travel_time = MapquestService.get_travel_info(origin, destination)[:route][:formattedTime]
        expect(travel_time).to eq("80:32:14")

        road_trip_arrival_time = RoadTripFacade.new(origin, destination).get_arrival_time(travel_time)

        expect(road_trip_arrival_time).to be_a(Time)
        # expect(road_trip_arrival_time.to_s).to eq("2023-04-29 02:35:04 -0600") ran at 6:03pm on 4/25/2023
      end
    end

    it "returns arrival time, Denver,CO to Pueblo,CO" do
      VCR.use_cassette("arrival_time/pueblo_road_trip_facade_arrival_time") do
        origin = "Denver,CO"
        destination = "Pueblo,CO"
        travel_time = MapquestService.get_travel_info(origin, destination)[:route][:formattedTime]
        expect(travel_time).to eq("01:43:03")

        road_trip_arrival_time = RoadTripFacade.new(origin, destination).get_arrival_time(travel_time)

        expect(road_trip_arrival_time).to be_a(Time)
        # expect(road_trip_arrival_time.to_s).to eq("2023-04-25 19:48:37 -0600") ran at 6:05pm on 4/25/2023
      end
    end
  end

  describe "#create_weather_hash" do
    it "returns a weather hash of specific attributes for the destination, NY to LA" do
      VCR.use_cassette("create_weather_hash/la_road_trip_facade_create_weather_hash") do
        origin = "New York,NY"
        destination = "Los Angeles,CA"
        # travel_time = MapquestService.get_travel_info(origin, destination)[:route][:formattedTime]
        # expect(travel_time).to eq("40:14:00")

        weather_at_destination = RoadTripFacade.new(origin, destination).forecast_at_destination
        weather_info = weather_at_destination[:forecast][:forecastday][2][:hour][11]

        road_trip_weather_hash = RoadTripFacade.new(origin, destination).create_weather_hash(weather_info)

        expect(road_trip_weather_hash).to be_a(Hash)
        expect(road_trip_weather_hash.keys).to eq([:datetime, :temperature, :condition])
        expect(road_trip_weather_hash[:datetime]).to be_a(String)
        expect(road_trip_weather_hash[:datetime]).to eq("2023-04-27 11:00")
        expect(road_trip_weather_hash[:temperature]).to be_a(Float)
        expect(road_trip_weather_hash[:temperature]).to eq(81.1)
        expect(road_trip_weather_hash[:condition]).to be_a(String)
        expect(road_trip_weather_hash[:condition]).to eq("Sunny")
      end
    end
  end

  describe "#new_adventure" do
    it "returns a road trip object with specific attributes, NY to LA" do
      VCR.use_cassette("new_adventure/la_road_trip_facade_new_adventure") do
        origin = "New York,NY"
        destination = "Los Angeles,CA"

        road_trip = RoadTripFacade.new(origin, destination).new_adventure

        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.id).to eq(nil)
        expect(road_trip.start_city).to be_a(String)
        expect(road_trip.start_city).to eq("New York,NY")
        expect(road_trip.end_city).to be_a(String)
        expect(road_trip.end_city).to eq("Los Angeles,CA")
        expect(road_trip.travel_time).to be_a(String)
        expect(road_trip.travel_time).to eq("40:13:49")
        expect(road_trip.weather_at_eta).to be_a(Hash)
        expect(road_trip.weather_at_eta.keys).to eq([:datetime, :temperature, :condition])
        expect(road_trip.weather_at_eta[:datetime]).to be_a(String)
        expect(road_trip.weather_at_eta[:datetime]).to eq("2023-04-27 11:00")
        expect(road_trip.weather_at_eta[:temperature]).to be_a(Float)
        expect(road_trip.weather_at_eta[:temperature]).to eq(81.1)
        expect(road_trip.weather_at_eta[:condition]).to be_a(String)
        expect(road_trip.weather_at_eta[:condition]).to eq("Sunny")
      end
    end

    it "returns a road trip object with specific attributes, New York,NY to Panama City,Panama" do
      VCR.use_cassette("new_adventure/panama_road_trip_facade_new_adventure") do
        origin = "New York,NY"
        destination = "Panama City,Panama"

        road_trip = RoadTripFacade.new(origin, destination).new_adventure

        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.id).to eq(nil)
        expect(road_trip.start_city).to be_a(String)
        expect(road_trip.start_city).to eq("New York,NY")
        expect(road_trip.end_city).to be_a(String)
        expect(road_trip.end_city).to eq("Panama City,Panama")
        expect(road_trip.travel_time).to be_a(String)
        expect(road_trip.travel_time).to eq("80:31:59")
        expect(road_trip.weather_at_eta).to be_a(Hash)
        expect(road_trip.weather_at_eta.keys).to eq([:datetime, :temperature, :condition])
        expect(road_trip.weather_at_eta[:datetime]).to be_a(String)
        expect(road_trip.weather_at_eta[:datetime]).to eq("2023-04-29 04:00")
        expect(road_trip.weather_at_eta[:temperature]).to be_a(Float)
        expect(road_trip.weather_at_eta[:temperature]).to eq(75.0)
        expect(road_trip.weather_at_eta[:condition]).to be_a(String)
        expect(road_trip.weather_at_eta[:condition]).to eq("Clear")
      end
    end

    it "returns a road trip object with impossible travel time, New York,NY to London,UK" do
      VCR.use_cassette("new_adventure/london_road_trip_facade_new_adventure") do
        origin = "New York,NY"
        destination = "London,UK"

        road_trip = RoadTripFacade.new(origin, destination).new_adventure

        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.id).to eq(nil)
        expect(road_trip.start_city).to be_a(String)
        expect(road_trip.start_city).to eq("New York,NY")
        expect(road_trip.end_city).to be_a(String)
        expect(road_trip.end_city).to eq("London,UK")
        expect(road_trip.travel_time).to be_a(String)
        expect(road_trip.travel_time).to eq("Impossible Route")
        expect(road_trip.weather_at_eta).to eq({})
      end
    end
  end
end
