# Data representing a singular shipment. It accepts Ruby hashes
# and will convert them to XML for the Pilot Freight Services API.
# Shipments processes are mainly covered by flags, so for different actions
# we just over ride the flags and then send as normal.
#
# @param [Hash] attributes The attributes of the shipment. See: https://github.com/MFSTech/SendUsShipments/blob/master/Shipment.xml
module PilotFreight
  class Shipment

    attr_accessor :attrs

    def initialize(attributes={})
      @attrs = attributes || {}
    end

    # Crafts the required attributes for a shipment that will not
    # register it with Pilot but only retrieve the rate.
    def rate
      send(@attrs.merge('Flags' => []))
    end

    def register
      send(@attrs.merge('Flags' => ['Register']))
    end

    def cancel
    end

    def send(attrs=nil)
      PilotFreight::Client.post('/EDI/Cust/Shipment.asp', PilotFreight::XML.encode(attrs || @attrs))
    end

  end
end