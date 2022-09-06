# frozen_string_literal: true

RSpec.describe PilotFreight do
  it "has a version number" do
    expect(PilotFreight::VERSION).not_to be nil
  end

  describe ".configuration" do
    context "No rails, no env, no config" do
      it "has a blank config" do
        expect(PilotFreight.configuration.user_name).to eq(nil)
        expect(PilotFreight.configuration.password).to eq(nil)
        expect(PilotFreight.configuration.env).to eq('development')
      end
    end
    context "Rails, no env, no config" do
      it "will use the rails env" do
        expect(PilotFreight.configuration.user_name).to eq(nil)
      end
    end
  end
end
