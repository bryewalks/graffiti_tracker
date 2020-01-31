require_relative '../spec_helper'

module GraffitiTracker
  describe Alderman do
    describe "#initialize" do
      let(:alderman) { Alderman.new(name: "Brye Walker", ward_number: 1)}

      it "initializes with correct name" do
        expect(alderman.name).to eq("Brye Walker")
      end

      it "initializes with correct ward number" do
        expect(alderman.ward_number).to eq(1)
      end
    end
  end
end