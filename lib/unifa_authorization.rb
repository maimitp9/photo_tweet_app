# ======================================================
# Author: Maimit Patel
# Usage: Authorization with Authorization Server(UniFa) 
# Include Athorization related logic here
# ======================================================

require 'net/http'

module UnifaAuthorization
  # Authorization_url to get authorization code
  def authorization_url
    "#{Rails.application.secrets.site_path}/oauth/authorize?#{parametes}"
  end
  
  # Authorization_url Params
  def parametes
    "response_type=code&client_id=#{Rails.application.secrets.client_id}&redirect_uri=#{Rails.application.secrets.redirect_uri}"
  end

  # Get access_token from the Authorization Server
  # parametes required:
  # 1. authorization_code,2. client_id,3. client_secret, 4. redirect_uri, 5. grant_type
  def get_token(code)
    uri = URI("#{Rails.application.secrets.site_path}/oauth/token")
    res = Net::HTTP.post_form(uri, code: code, 
      client_id: Rails.application.secrets.client_id, 
      client_secret: Rails.application.secrets.client_secret, 
      redirect_uri: Rails.application.secrets.redirect_uri, 
      grant_type: 'authorization_code')
    JSON.parse(res.body)
  end 
end