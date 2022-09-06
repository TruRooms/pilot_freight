# frozen_string_literal: true

RSpec.describe PilotFreight::XML do
  describe ".encode" do
    context "with no attributes" do
      it "should return an empty string" do
        xml = PilotFreight::XML.encode({})
        expect(xml).to eq("")
      end
    end
    context "with any attributes" do
      it "should return a string" do
        xml = PilotFreight::XML.encode({ any: "attributes" })
        expect(xml).to be_a(String)
      end
      it "should return a string with nested attributes" do
        xml = PilotFreight::XML.encode({ pieces: [{ piece: "x" }, { piece: "y" }] })
        expect(xml).to eq("<pieces><piece>x</piece><piece>y</piece></pieces>")
      end
    end
  end

  describe ".decode" do
    context "with an empty string" do
      it "should return an empty hash" do
        hash = PilotFreight::XML.decode("")
        expect(hash).to eq(OpenStruct.new)
      end
    end
    context "with a properly formatted string" do
      it "should return a OpenStruct" do
        hash = PilotFreight::XML.decode("<any>attributes</any>")
        expect(hash).to be_a(OpenStruct)
      end
      it "should return a hash with nested attributes" do
        hash = PilotFreight::XML.decode("<pieces><piece>x</piece><piece>y</piece></pieces>")
        expect(hash).to eq(OpenStruct.new(pieces: OpenStruct.new(piece: %w[x y])))
      end
    end
  end

  describe ".to_open_struct" do
    context "with an empty hash" do
      it "returns an empty OpenStruct" do
        struct = PilotFreight::XML.to_open_struct({})
        expect(struct).to eq(OpenStruct.new)
      end
    end
    context "with a flat hash" do
      it "returns an OpenStruct with the same keys" do
        struct = PilotFreight::XML.to_open_struct({ any: "attributes" })
        expect(struct).to eq(OpenStruct.new({ any: "attributes" }))
      end
    end
    context "with a nested hash" do
      it "returns an OpenStruct with the same keys" do
        struct = PilotFreight::XML.to_open_struct({ any: { nested: "attributes" } })
        expect(struct).to eq(OpenStruct.new({ any: OpenStruct.new({ nested: "attributes" }) }))
      end
    end
  end
end
