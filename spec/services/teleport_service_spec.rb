require 'rails_helper'

describe TeleportService do
  describe "#get_salaries" do
    it "returns salaries for a location, Chicago" do
      VCR.use_cassette("teleport_chicago_salaries") do
        destination = "chicago"
        response = TeleportService.get_salaries(destination)

        expect(response).to be_a(Hash)
        expect(response[:salaries]).to be_an(Array)
        expect(response[:salaries][0].keys).to eq([:job, :salary_percentiles])

        expect(response[:salaries][0][:job]).to be_a(Hash)
        expect(response[:salaries][0][:job].keys).to eq([:id, :title])
        expect(response[:salaries][0][:job][:id]).to eq("ACCOUNT-MANAGER")
        expect(response[:salaries][0][:job][:title]).to eq("Account Manager")

        expect(response[:salaries][0][:salary_percentiles]).to be_a(Hash)
        expect(response[:salaries][0][:salary_percentiles].keys).to eq([:percentile_25, :percentile_50, :percentile_75])
        expect(response[:salaries][0][:salary_percentiles][:percentile_25]).to eq(53732.4997858553)
        expect(response[:salaries][0][:salary_percentiles][:percentile_75]).to eq(84227.57438186172)
      end
    end
  end
end