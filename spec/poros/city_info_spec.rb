require 'rails_helper'

RSpec.describe CityInfo do
  describe "#initialize" do
    it "creates a CityInfo object" do
      destination = "chicago"
      forecast = { summary: "Cloudy", temperature: "70" }
      salaries = [{ title: "Account Manager", min: "53732.4997858553", max: "84227.57438186172" },
                  { title: "Accountant", min: "53732.4997858553", max: "84227.57438186172" }
                ]

      city_info = CityInfo.new(destination, forecast, salaries)

      expect(city_info).to be_a(CityInfo)
      expect(city_info.id).to eq(nil)
      expect(city_info.instance_variables).to eq([:@destination, :@forecast, :@salaries])

      expect(city_info.destination).to eq('chicago')

      expect(city_info.forecast).to be_a(Hash)
      expect(city_info.forecast.keys).to eq([:summary, :temperature])
      expect(city_info.forecast[:summary]).to be_a(String)
      expect(city_info.forecast[:temperature]).to be_a(String)

      expect(city_info.salaries).to be_an(Array)
      expect(city_info.salaries.size).to eq(2)
      expect(city_info.salaries[0]).to be_a(Hash)
      expect(city_info.salaries[0].keys).to eq([:title, :min, :max])
      expect(city_info.salaries[0][:title]).to be_a(String)
      expect(city_info.salaries[0][:min]).to be_a(String)
      expect(city_info.salaries[0][:max]).to be_a(String)
    end
  end
end