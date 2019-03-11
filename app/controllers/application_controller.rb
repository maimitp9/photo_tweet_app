class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Authentication
  include SessionsHelper
  include OauthHelper
  # before_action :authenticate_user
end
