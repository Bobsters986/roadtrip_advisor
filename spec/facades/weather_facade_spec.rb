require 'rails_helper'

describe WeatherFacade do
  describe ".get_forecast" do
    it "returns weather forecast for a location, Denver,CO" do
      VCR.use_cassette("denver_weather_facade") do
        location = "Denver,CO"
        response = WeatherFacade.get_forecast(location)

        expect(response).to be_a(Forecast)
        expect(response.id).to eq(nil)
        expect(response.instance_variables).to eq([:@current_weather, :@daily_weather, :@hourly_weather])
        expect(response.instance_variables).to_not include(:@location, :@current, :@forecast)

        expect(response.current_weather).to be_a(Hash)
        expect(response.current_weather.size).to eq(8)
        expect(response.current_weather.keys).to eq([:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon])
        expect(response.current_weather.keys).to_not include(:last_updated_epoch, :wind_speed, :wind_direction, :pressure, :precip, :cloud, :feelslike_c, :temp_c)

        expect(response.daily_weather).to be_an(Array)
        expect(response.daily_weather.size).to eq(5)
        expect(response.daily_weather[0]).to be_a(Hash)
        expect(response.daily_weather[0].size).to eq(7)
        expect(response.daily_weather[0].keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon])
        expect(response.daily_weather[0].keys).to_not include(:date_epoch, :astro, :avgtemp_, :maxwind_mph, :daily_chance_of_rain, :daily_will_it_snow, :uv)

        expect(response.hourly_weather).to be_an(Array)
        expect(response.hourly_weather.size).to eq(24)
        expect(response.hourly_weather[0]).to be_a(Hash)
        expect(response.hourly_weather[0].size).to eq(4)
        expect(response.hourly_weather[0].keys).to eq([:time, :temperature, :conditions, :icon])
        expect(response.hourly_weather[0].keys).to_not include(:time_epoch, :wind_mph, :wind_degree, :pressure_in, :precip_in, :humidity, :cloud)
      end
    end
  end
end