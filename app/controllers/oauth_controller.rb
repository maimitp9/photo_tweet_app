class OauthController < ApplicationController
  include UnifaAuthorization

  # GET '/oauth/authorize'
  # call the Autorization provider to get authorization code
  def authorize
    redirect_to authorization_url
  end

  # GET '/oauth/callback'
  # callback url called from authorization provider with authorization code
  def callback
    response = get_token(params["code"]) # call with autorization code to fetch access_token
    auth_token response["access_token"] if response["access_token"] # set access token into sression if any
    redirect_to images_path
  end
end
