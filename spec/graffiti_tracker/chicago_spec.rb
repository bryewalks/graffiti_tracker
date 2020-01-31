require_relative '../spec_helper'

module GraffitiTracker
  describe Chicago do
    describe "#initialize" do
      let(:chicago) { Chicago.new(search_name: "Brye Walker", month: 01, year: 2019)}

      it "initializes with correct search name" do
        expect(chicago.search_name).to eq("Brye Walker")
      end

      it "initializes with correct month" do
        expect(chicago.month).to eq(01)
      end

      it "initializes with correct year" do
        expect(chicago.year).to eq(2019)
      end
    end
  end
end