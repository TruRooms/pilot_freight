# frozen_string_literal: true

RSpec.describe PilotFreight::Shipment do
  describe "#rate" do
    context "with no attributes" do
      it "should return an empty string" do
        shipment = PilotFreight::Shipment.new({})
        resp = shipment.rate
        expect(resp[:code]).to eq(200)
      end
    end
  end
end
