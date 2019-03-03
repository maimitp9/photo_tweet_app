require 'test_helper'

class OauthControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(user_name: 'test_user', password: 'test_password', password_confirmation: 'test_password')
  end
  
  test "should get login page if unauthenticated user" do
    get '/oauth/callback'
    follow_redirect!
    assert_equal "/login", path
  end

  test "should get callback if authenticated user" do
    login_as(@user)
    get '/oauth/callback'
    follow_redirect!
    assert_response :success
    assert_equal "/images", path
  end

  test "authorization link should be active if unauthorizeed with server" do
    login_as(@user)
    get '/images'
    assert_response :success
    assert_select 'a', I18n.t('screen.images.index.my_tweet_link')
  end
end

