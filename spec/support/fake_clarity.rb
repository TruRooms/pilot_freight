# frozen_string_literal: true

require "sinatra/base"

class FakeClarity < Sinatra::Base
  # Stub for the send shipments endpoint
  post "/EDI/Cust/Shipment.asp" do
    xml_response(200, "successful_ack.xml")
  end

  private

  def xml_response(response_code, file_name)
    content_type "text/xml"
    status response_code
    File.open("#{File.dirname(__FILE__)}/fixtures/#{file_name}", "rb").read
  end
end
