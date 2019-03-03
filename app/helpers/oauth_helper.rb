module OauthHelper
  # store the given authentication token
  def auth_token(token)
    session[:token] = token
  end

  # return true is authentication token set otherwise false
  def authorized?
    !session[:token].nil?
  end

  # return the authentication tokal
  def get_token
    session[:token] if authorized?
  end
end
