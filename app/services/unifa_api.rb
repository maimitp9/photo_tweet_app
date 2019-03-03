# ===================================
# Author: Maimit Patel
# Usage: Call API Endpoint
# Define other method as per requirement 
# ===================================
require 'net/http'

module UnifaApi
  # Call POST API accepting parameters as Hash
  # required parameters are:
  # -> api_url, request_body and authentication token
  def self.call_post_api(args)
    api_url = args[:api_url]
    body = args[:body]
    token = args[:token]

    uri = URI(api_url)
    return Net::HTTP.start(uri.host, nil, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json'
      req['Authorization'] = "Bearer #{token}"
      req.body = body.to_json
      http.request(req)
    end
  end
end