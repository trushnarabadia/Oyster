require_relative '../lib/station'

describe Station do
    let(:station){ Station.new("Baker Street", 1)}

    it "is initialized with a zone" do
        expect(station.zone).to eq 1
    end

    it "is initialized with a name" do
        expect(station.name).to eq "Baker Street"
    end
end