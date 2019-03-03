module SessionsHelper
  # logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # Returns true if the user is logged in. false otherwise
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user
  def log_out
    session.delete(:user_id)
    session.delete(:token)
    @current_user = nil
  end

  # Check user is logged in or not
  def authenticate_user
    unless logged_in?
      redirect_to login_path, error: I18n.t('errors.log_in.unautenticate')
    end
  end
end
