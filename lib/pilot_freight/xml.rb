# frozen_string_literal: true

require "active_support/core_ext/hash/conversions"

# Quickly and easily encode/decode XML for Pilot Freight Services
# into Ruby hashes. As of current, we don't run any case transformations
# or anything like that. We just want to get the data in and out. All transforms
# are handled by Gyoku.
module PilotFreight
  class XML
    # Encodes a hash into XML for Pilot Freight Services.
    # @param hash [Hash] The hash to encode.
    # @return [String] The XML string.
    def self.encode(hash)
      return "" if hash.empty?

      Gyoku.xml(hash, { unwrap: true })
    end

    # Encodes and then validates the hash.
    # @param hash [Hash] The hash to encode and validate.
    # @return [String] XML string.
    # @raise [PilotFreight::InvalidXML] If the XML is invalid.
    def self.encode_and_validate(hash)
      encoded = encode(hash)
      errors = validate(encoded)
      raise PilotFreight::InvalidXML, "Invalid XML: #{errors}" if errors.length.positive?

      encoded
    end

    # Decodes XML into a set of open structs.
    # @param xml [String] The XML to decode.
    # @return [OpenStruct] The decoded XML.
    def self.decode(xml)
      to_open_struct(Hash.from_xml(xml))
    end

    # Uses nokogiri to validate the XML against the DTD.
    # @param xml [String] The XML to validate.
    # @return [Array] Array of errors. Empty if no errors present.
    def self.validate(xml)
      dtd = Nokogiri::XML::DTD.new("dtd",
                                   Nokogiri::XML::Document.parse(File.open(File.join(File.dirname(__FILE__),
                                                                                     "support/shipment.dtd"))))
      document = Nokogiri::XML(xml)
      dtd.validate(document)
    end

    # Recursively convert a hash to OpenStructs.
    # @param hash [Hash] The hash to convert.
    # @return [OpenStruct] The converted hash.
    def self.to_open_struct(hash)
      return OpenStruct.new if hash.nil? || hash.length.zero?

      hash.each do |k, v|
        if v.is_a? Hash
          hash[k] = to_open_struct(v)
        else
          return OpenStruct.new(hash)
        end
      end
      OpenStruct.new(hash)
    end
  end
end
