require_relative '../spec_helper'

module GraffitiTracker
  describe RemovalRequest do
    describe "#initialize" do
      let(:removal_request) {RemovalRequest.new(
                                                creation_date: "2014-05-08T00:00:00.000",
                                                completion_date: "2018-05-08T00:00:00.000",
                                                street_address: "123 main st"
        )}

      it "initializes with correct creation date" do
        expect(removal_request.creation_date).to eq("2014-05-08T00:00:00.000")
      end

      it "initializes with correct completion date" do
        expect(removal_request.completion_date).to eq("2018-05-08T00:00:00.000")
      end

      it "initializes with correct street address" do
        expect(removal_request.street_address).to eq("123 main st")
      end
    end

    describe "#completed?" do
      let(:removal_request) {RemovalRequest.new(
                                                creation_date: "2014-05-08T00:00:00.000",
                                                completion_date: "2018-05-08T00:00:00.000",
                                                street_address: "123 main st"
                                              )}
      it "returns true if completed" do
        expect(removal_request.completed?).to eq(true)
      end
    end
  end
end