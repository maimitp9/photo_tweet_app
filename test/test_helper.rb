require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
include CustomActiveStorage

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Returns the current logged-in user (if any)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  # Returns true if the user is logged in. false otherwise
  def is_logged_in?
    !current_user.nil?
  end

  class ActionDispatch::IntegrationTest

    # Log in as a particular user.
    def login_as(user)
      post '/login', params: { session: { user_name: user.user_name,
                                            password: user.password } }
    end
  end
end
