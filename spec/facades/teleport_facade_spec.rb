require 'rails_helper'

describe TeleportFacade do
  describe ".city_info" do
    it "returns weather forecast and salaries for a destination city, chicago" do
      VCR.use_cassette("teleport_chicago_city_info") do
        destination = "chicago"
        response = TeleportFacade.city_info(destination)

        expect(response).to be_a(CityInfo)
        expect(response.id).to eq(nil)
        expect(response.instance_variables).to eq([:@destination, :@forecast, :@salaries])

        expect(response.destination).to eq('chicago')

        expect(response.forecast).to be_a(Hash)
        expect(response.forecast.keys).to eq([:summary, :temperature])
        expect(response.forecast[:summary]).to be_a(String)
        expect(response.forecast[:temperature]).to be_a(String)

        expect(response.salaries).to be_an(Array)
        expect(response.salaries[0]).to be_a(Hash)
        expect(response.salaries[0].keys).to eq([:title, :min, :max])
        expect(response.salaries[0][:title]).to be_a(String)
        expect(response.salaries[0][:min]).to be_a(String)
        expect(response.salaries[0][:max]).to be_a(String)
      end
    end
  end
end