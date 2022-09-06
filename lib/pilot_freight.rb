# frozen_string_literal: true

require "ostruct"

require "nokogiri"
require "gyoku"
require "httparty"

require_relative "pilot_freight/shipment"
require_relative "pilot_freight/client"
require_relative "pilot_freight/xml"
require_relative "pilot_freight/version"

module PilotFreight
  class Error < StandardError; end
  class InsufficientConfiguration < StandardError; end
  class InvalidXML < StandardError; end

  # The default configuration object. Uses an ostruct to allow for
  # dot notation access to the configuration attributes.
  def self.configuration
    @@configuration ||= OpenStruct.new(
      user_name: ENV["PILOT_FREIGHT_USER_NAME"] || nil,
      password: ENV["PILOT_FREIGHT_PASSWORD"] || nil,
      env: ENV['PILOT_FREIGHT_ENV'] || 'development'
    )
  end

  # Allows configuration options to be set in a block.
  def self.configure
    yield(configuration)
  end

  # Specify the endpoint that the client will use
  # based on which environment is specified
  # @return [String] The endpoint URL
  def self.endpoint
    if configuration.env == 'production'
      'http://edi.mfsclarity.com'
    else
      'http://demo.mfsclarity.com'
    end
  end

end
