module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user
  end

  # logs in the given user
  def log_in(user)
    reset_session
    session[:user_id] = user.id
  end

  # Logs out the current user
  def log_out
    session.delete(:user_id)
    session.delete(:token)
    @current_user = nil
    reset_session
  end

  # Check user is logged in or not
  def authenticate_user
    unless logged_in?
      redirect_to login_path, error: I18n.t('errors.log_in.unautenticate')
    end
  end
end
