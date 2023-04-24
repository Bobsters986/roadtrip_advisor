require 'rails_helper'

describe WeatherService do
  describe ".forecast" do
    it "returns weather forecast for a location with latitude and longitude, Denver,CO" do
      VCR.use_cassette("denver_weather_forecast") do
        lat = 39.74001
        lng = -104.99202
        response = WeatherService.forecast(lat, lng)

        expect(response).to be_a(Hash)
        expect(response[:location].size).to eq(8) 
        expect(response[:location]).to have_key(:name)
        expect(response[:location][:name]).to be_a(String)
        expect(response[:location][:name]).to eq("Denver")

        expect(response[:current]).to be_a(Hash)
        expect(response[:current].size).to eq(23)

        expect(response[:forecast]).to be_a(Hash)
        expect(response[:forecast][:forecastday]).to be_an(Array)
        expect(response[:forecast][:forecastday].size).to eq(5) #5 days of forecast

        expect(response[:forecast][:forecastday][0].size).to eq(5)
        expect(response[:forecast][:forecastday][0][:hour]).to be_an(Array)
        expect(response[:forecast][:forecastday][0][:hour].size).to eq(24) #24 hours of forecast
      end
    end
  end

  describe ".city_name_forecast" do
    it "returns weather forecast for a location with city name, chicago" do
      VCR.use_cassette("chicago_weather_forecast") do
        city = "chicago"
        response = WeatherService.city_name_forecast(city)

        expect(response).to be_a(Hash)
        expect(response[:location].size).to eq(8) 
        expect(response[:location]).to have_key(:name)
        expect(response[:location][:name]).to be_a(String)
        expect(response[:location][:name]).to eq("Chicago")

        expect(response[:current]).to be_a(Hash)
        expect(response[:current].size).to eq(23)
        expect(response[:current][:temp_f]).to be_a(Float)
        expect(response[:current][:condition][:text]).to be_a(String)

        expect(response[:forecast]).to be_a(Hash)
        expect(response[:forecast][:forecastday]).to be_an(Array)
        expect(response[:forecast][:forecastday].size).to eq(5) #5 days of forecast

        expect(response[:forecast][:forecastday][0].size).to eq(5)
        expect(response[:forecast][:forecastday][0][:hour]).to be_an(Array)
        expect(response[:forecast][:forecastday][0][:hour].size).to eq(24) #24 hours of forecast
      end
    end
  end
end