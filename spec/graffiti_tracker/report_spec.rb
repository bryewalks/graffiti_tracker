require_relative '../spec_helper'

module GraffitiTracker
  describe Report do
    describe "#initialize" do
      let(:report) { Report.new(alderman_name: "Brye Walker", ward_number: 1, month: 05, year: 1991, graffiti_removal_requests: 12)}

      it "initializes with correct alderman name" do
        expect(report.alderman_name).to eq("Brye Walker")
      end

      it "initializes with correct ward number" do
        expect(report.ward_number).to eq(1)
      end

      it "initializes with correct month" do
        expect(report.month).to eq(05)
      end

      it "initializes with correct year" do
        expect(report.year).to eq(1991)
      end

      it "initializes with correct graffiti removal requests" do
        expect(report.graffiti_removal_requests).to eq(12)
      end
    end
  end
end