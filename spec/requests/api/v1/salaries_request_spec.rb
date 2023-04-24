require 'rails_helper'

RSpec.describe 'Teleport Salaries API' do
  context "#show" do
    context 'when successful' do
      it 'sends destination name, current weather, and salaries for a city: Chicago' do
        VCR.use_cassette('teleport_chicago_city_info') do
          destination = "Chicago"
          get "/api/v1/salaries?destination=#{destination}"

          expect(response).to be_successful

          city_info = JSON.parse(response.body, symbolize_names: true)

          expect(city_info[:data]).to be_a(Hash)
          expect(city_info[:data].keys).to eq([:id, :type, :attributes])
          expect(city_info[:data][:id]).to eq(nil)
          expect(city_info[:data][:type]).to eq('salaries')
          expect(city_info[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])
          expect(city_info[:data][:attributes][:destination]).to eq('chicago')

          expect(city_info[:data][:attributes][:forecast]).to be_a(Hash)
          expect(city_info[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
          expect(city_info[:data][:attributes][:forecast][:summary]).to be_a(String)
          expect(city_info[:data][:attributes][:forecast][:temperature]).to be_a(String)

          expect(city_info[:data][:attributes][:salaries]).to be_an(Array)
          expect(city_info[:data][:attributes][:salaries].size).to eq(7)
          expect(city_info[:data][:attributes][:salaries][0]).to be_a(Hash)
          expect(city_info[:data][:attributes][:salaries][0].keys).to eq([:title, :min, :max])
          expect(city_info[:data][:attributes][:salaries][0][:title]).to be_a(String)
          expect(city_info[:data][:attributes][:salaries][0][:min]).to be_a(String)
          expect(city_info[:data][:attributes][:salaries][0][:max]).to be_a(String)
        end
      end

      it 'sends destination name, current weather, and salaries for a city: Denver' do
        VCR.use_cassette('teleport_denver_city_info') do
          destination = "Denver"
          get "/api/v1/salaries?destination=#{destination}"

          expect(response).to be_successful

          city_info = JSON.parse(response.body, symbolize_names: true)

          expect(city_info[:data]).to be_a(Hash)
          expect(city_info[:data].keys).to eq([:id, :type, :attributes])
          expect(city_info[:data][:id]).to eq(nil)
          expect(city_info[:data][:type]).to eq('salaries')
          expect(city_info[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])
          expect(city_info[:data][:attributes][:destination]).to eq('denver')

          expect(city_info[:data][:attributes][:forecast]).to be_a(Hash)
          expect(city_info[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
          expect(city_info[:data][:attributes][:forecast][:summary]).to be_a(String)
          expect(city_info[:data][:attributes][:forecast][:temperature]).to be_a(String)

          expect(city_info[:data][:attributes][:salaries]).to be_an(Array)
          expect(city_info[:data][:attributes][:salaries].size).to eq(7)
          expect(city_info[:data][:attributes][:salaries][0]).to be_a(Hash)
          expect(city_info[:data][:attributes][:salaries][0].keys).to eq([:title, :min, :max])
          expect(city_info[:data][:attributes][:salaries][0][:title]).to be_a(String)
          expect(city_info[:data][:attributes][:salaries][0][:min]).to be_a(String)
          expect(city_info[:data][:attributes][:salaries][0][:max]).to be_a(String)
        end
      end
    end
  end
end