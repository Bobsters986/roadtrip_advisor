require 'rails_helper'

RSpec.describe Forecast do
  describe "#initialize" do
    it "can create a forecast object from 3 different collections" do

      current_weather = {
        last_updated: "2023-04-23 12:00",
        temperature: 52.0,
        feels_like: 48.0,
        humidity: 40,
        uvi: 3.0,
        visibility: 9.0,
        condition: "Sunny",
        icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"
      }

      daily_weather = [
        {
          date: "2023-04-23",
          sunrise: "06:11 AM",
          sunset: "07:30 PM",
          max_temp: 61.7,
          min_temp: 32.0,
          condition: "Sunny",
          icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"
        },
        {
          date: "2023-04-24",
          sunrise: "06:10 AM",
          sunset: "07:31 PM",
          max_temp: 60.5,
          min_temp: 34.0,
          condition: "Sunny",
          icon: "//cdn.weatherapi.com/weather/64x64/day/118.png"
        },
        {
          date: "2023-04-25",
          sunrise: "06:09 AM",
          sunset: "07:32 PM",
          max_temp: 60.3,
          min_temp: 33.0,
          condition: "Cloudy",
          icon: "//cdn.weatherapi.com/weather/64x64/day/120.png"
        },
        {
          date: "2023-04-26",
          sunrise: "06:08 AM",
          sunset: "07:33 PM",
          max_temp: 60.1,
          min_temp: 33.0,
          condition: "Partly cloudy",
          icon: "//cdn.weatherapi.com/weather/64x64/day/122.png"
        },
        {
          date: "2023-04-27",
          sunrise: "06:07 AM",
          sunset: "07:34 PM",
          max_temp: 60.0,
          min_temp: 32.0,
          condition: "Sunny",
          icon: "//cdn.weatherapi.com/weather/64x64/day/116.png"
        }
      ]

      hourly_weather = [
        { time: "2023-04-23 00:00", temperature: 32.1, conditions: "Overcast", icon: "//cdn.weatherapi.com/weather/64x64/day/118.png" },
        { time: "2023-04-23 1:00", temperature: 33.0, conditions: "Overcast", icon: "//cdn.weatherapi.com/weather/64x64/day/118.png" },
        { time: "2023-04-23 2:00", temperature: 35.0, conditions: "Overcast", icon: "//cdn.weatherapi.com/weather/64x64/day/118.png" },
        { time: "2023-04-23 3:00", temperature: 36.6, conditions: "Overcast", icon: "//cdn.weatherapi.com/weather/64x64/day/118.png" },
        { time: "2023-04-23 4:00", temperature: 36.0, conditions: "Overcast", icon: "//cdn.weatherapi.com/weather/64x64/day/118.png" },
        { time: "2023-04-23 5:00", temperature: 36.4, conditions: "Overcast", icon: "//cdn.weatherapi.com/weather/64x64/day/118.png" },
        { time: "2023-04-23 6:00", temperature: 36.9, conditions: "Overcast", icon: "//cdn.weatherapi.com/weather/64x64/day/118.png" },
        { time: "2023-04-23 7:00", temperature: 38.0, conditions: "Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/120.png" },
        { time: "2023-04-23 8:00", temperature: 38.6, conditions: "Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/120.png" },
        { time: "2023-04-23 9:00", temperature: 40.0, conditions: "Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/120.png" },
        { time: "2023-04-23 10:00", temperature: 42.2, conditions: "Partly loudy", icon: "//cdn.weatherapi.com/weather/64x64/day/122.png" },
        { time: "2023-04-23 11:00", temperature: 44.0, conditions: "Partly cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/122.png" },
        { time: "2023-04-23 12:00", temperature: 46.6, conditions: "Partly cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/122.png" },
        { time: "2023-04-23 13:00", temperature: 48.0, conditions: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png" },
        { time: "2023-04-23 14:00", temperature: 50.5, conditions: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png" },
        { time: "2023-04-23 15:00", temperature: 52.0, conditions: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png" },
        { time: "2023-04-23 16:00", temperature: 54.0, conditions: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png" },
        { time: "2023-04-23 17:00", temperature: 56.8, conditions: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png" },
        { time: "2023-04-23 18:00", temperature: 58.0, conditions: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/116.png" },
        { time: "2023-04-23 19:00", temperature: 57.3, conditions: "Clear skies", icon: "//cdn.weatherapi.com/weather/64x64/day/121.png" },
        { time: "2023-04-23 20:00", temperature: 56.0, conditions: "Clear skies", icon: "//cdn.weatherapi.com/weather/64x64/day/121.png" },
        { time: "2023-04-23 21:00", temperature: 50.0, conditions: "Clear skies", icon: "//cdn.weatherapi.com/weather/64x64/day/121.png" },
        { time: "2023-04-23 22:00", temperature: 44.7, conditions: "Clear skies", icon: "//cdn.weatherapi.com/weather/64x64/day/121.png" },
        { time: "2023-04-23 23:00", temperature: 38.0, conditions: "Clear skies", icon: "//cdn.weatherapi.com/weather/64x64/day/121.png" }
      ]

      forecast = Forecast.new(current_weather, daily_weather, hourly_weather)

      expect(forecast).to be_a(Forecast)
      expect(forecast.id).to eq(nil)
      expect(forecast.current_weather).to be_a(Hash)
      expect(forecast.current_weather).to eq(current_weather)
      expect(forecast.current_weather[:last_updated]).to be_a(String)
      expect(forecast.current_weather[:temperature]).to be_a(Float)
      expect(forecast.current_weather[:feels_like]).to be_a(Float)
      expect(forecast.current_weather[:humidity]).to be_a(Integer)
      expect(forecast.current_weather[:uvi]).to be_a(Float)
      expect(forecast.current_weather[:visibility]).to be_a(Float)
      expect(forecast.current_weather[:condition]).to be_a(String)
      expect(forecast.current_weather[:icon]).to be_a(String)

      expect(forecast.daily_weather).to be_a(Array)
      expect(forecast.daily_weather.size).to eq(5)
      expect(forecast.daily_weather).to eq(daily_weather)
      expect(forecast.daily_weather[0]).to be_a(Hash)
      expect(forecast.daily_weather[0][:date]).to be_a(String)
      expect(forecast.daily_weather[0][:sunrise]).to be_a(String)
      expect(forecast.daily_weather[0][:sunset]).to be_a(String)
      expect(forecast.daily_weather[0][:max_temp]).to be_a(Float)
      expect(forecast.daily_weather[0][:min_temp]).to be_a(Float)
      expect(forecast.daily_weather[0][:condition]).to be_a(String)
      expect(forecast.daily_weather[0][:icon]).to be_a(String)

      expect(forecast.hourly_weather).to be_a(Array)
      expect(forecast.hourly_weather.size).to eq(24)
      expect(forecast.hourly_weather).to eq(hourly_weather)
      expect(forecast.hourly_weather[0]).to be_a(Hash)
      expect(forecast.hourly_weather[0][:time]).to be_a(String)
      expect(forecast.hourly_weather[0][:temperature]).to be_a(Float)
      expect(forecast.hourly_weather[0][:conditions]).to be_a(String)
      expect(forecast.hourly_weather[0][:icon]).to be_a(String)
    end
  end
end