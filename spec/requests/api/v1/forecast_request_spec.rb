require 'rails_helper'

RSpec.describe 'Forecast API' do
  context 'when successful' do
    it 'sends a forecast for a city' do
      VCR.use_cassette('denver_forecast') do
        get '/api/v1/forecast?location=denver,co'

        expect(response).to be_successful

        forecast = JSON.parse(response.body, symbolize_names: true)

        expect(forecast[:data]).to be_a(Hash)
        expect(forecast[:data].keys).to eq([:id, :type, :attributes])
        expect(forecast[:data][:id]).to eq(nil)
        expect(forecast[:data][:type]).to eq('forecast')
        expect(forecast[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])
        expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)
        expect(forecast[:data][:attributes][:current_weather].size).to eq(8)

        expect(forecast[:data][:attributes][:daily_weather]).to be_an(Array)
        expect(forecast[:data][:attributes][:daily_weather].size).to eq(5) #5 days of forecast
        expect(forecast[:data][:attributes][:daily_weather][0]).to be_a(Hash)
        expect(forecast[:data][:attributes][:daily_weather][0].size).to eq(7)

        expect(forecast[:data][:attributes][:hourly_weather]).to be_an(Array)
        expect(forecast[:data][:attributes][:hourly_weather].size).to eq(24) #24 hours of forecast
        expect(forecast[:data][:attributes][:hourly_weather][0]).to be_a(Hash)
        expect(forecast[:data][:attributes][:hourly_weather][0].size).to eq(4)
      end
    end
  end
end