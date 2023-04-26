require 'rails_helper'

describe MapquestService do
  describe ".get_coordinates" do
    it "returns coordinates for a location, Denver,CO" do
      VCR.use_cassette("mapquest_denver_coordinates") do
        location = "Denver,CO"
        response = MapquestService.get_coordinates(location)

        expect(response).to be_a(Hash)
        expect(response[:results][0][:providedLocation][:location]).to eq("Denver,CO")
        expect(response[:results][0][:locations][0][:latLng]).to have_key(:lat)
        expect(response[:results][0][:locations][0][:latLng]).to have_key(:lng)
        expect(response[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
        expect(response[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
        expect(response[:results][0][:locations][0][:latLng][:lat]).to eq(39.74001)
        expect(response[:results][0][:locations][0][:latLng][:lng]).to eq(-104.99202)
      end
    end

    it "returns coordinates for a location, Los Angeles,CA" do
      VCR.use_cassette("mapquest_la_coordinates") do
        location = "Los Angeles,CA"
        response = MapquestService.get_coordinates(location)

        expect(response).to be_a(Hash)
        expect(response[:results][0][:providedLocation][:location]).to eq("Los Angeles,CA")
        expect(response[:results][0][:locations][0][:latLng]).to have_key(:lat)
        expect(response[:results][0][:locations][0][:latLng]).to have_key(:lng)
        expect(response[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
        expect(response[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
        expect(response[:results][0][:locations][0][:latLng][:lat]).to eq(34.05357)
        expect(response[:results][0][:locations][0][:latLng][:lng]).to eq(-118.24545)
      end
    end
  end

  describe ".get_travel_info" do
    it "returns travel info for a trip, Denver,CO to Pueblo,CO" do
      VCR.use_cassette("mapquest_denver_to_pueblo") do
        origin = "Denver,CO"
        destination = "Pueblo,CO"
        response = MapquestService.get_travel_info(origin, destination)

        expect(response).to be_a(Hash)
        expect(response[:route]).to have_key(:formattedTime)
        expect(response[:route][:formattedTime]).to be_a(String)
        expect(response[:route][:formattedTime]).to eq("01:43:03")
        expect(response[:route][:locations].first[:adminArea5]).to eq("Denver")
        expect(response[:route][:locations].last[:adminArea5]).to eq("Pueblo")
        expect(response[:route][:locations].last[:latLng][:lat]).to eq(38.26375)
        expect(response[:route][:locations].last[:latLng][:lng]).to eq(-104.61252)
      end
    end
  end
end