require_relative '../spec_helper'

module GraffitiTracker
  describe RemovalRequest do
    describe "#initialize" do
      let(:removal_request) {RemovalRequest.new(date: "2014-05-08T00:00:00.000")}

      it "initializes with correct date" do
        expect(removal_request.date).to eq("2014-05-08T00:00:00.000")
      end
    end
  end
end