# frozen_sting_literal: true

# Responsible for handling the HTTP requests to the 
# Pilot Freight API.
class PilotFreight::Client

  # POST a payload to the specified path.
  # @param path [String] The path to post to.
  # @param payload [String] The XML payload to post.
  # @return [Hash] {code: [Integer], body: [String]}
  def self.post(path, payload)
    resp = HTTParty.post(
      "#{PilotFreight.endpoint}#{path}", 
      body: payload, 
      headers: { 'Content-Type' => 'application/xml' })
    { code: resp.code, body: resp.body }
  end

end