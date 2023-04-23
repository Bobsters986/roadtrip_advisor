require 'rails_helper'

describe MapquestService do
  describe "#get_coordinates" do
    it "returns coordinates for a location" do
      VCR.use_cassette("mapquest_denver_coordinates") do
        location = "Denver,CO"
        response = MapquestService.get_coordinates(location)

        expect(response).to be_a(Hash)
        expect(response[:results][0][:locations][0][:latLng]).to have_key(:lat)
        expect(response[:results][0][:locations][0][:latLng]).to have_key(:lng)
        expect(response[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
        expect(response[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
        expect(response[:results][0][:locations][0][:latLng][:lat]).to eq(39.74001)
        expect(response[:results][0][:locations][0][:latLng][:lng]).to eq(-104.99202)
      end
    end
  end
end