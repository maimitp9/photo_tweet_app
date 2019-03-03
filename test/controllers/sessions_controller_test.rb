require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(user_name: 'test_user', password: 'test_password', password_confirmation: 'test_password')
  end

  test 'should get new' do
    get '/login'
    assert_response :success
  end

  test 'should not login with invalid details' do
    get '/login'
    post '/login', params: { session: { user_name: 'fake_user', password: 'fake_password'} }
    assert_equal 200, status
    assert_select 'div', I18n.t('errors.log_in.create')
    assert_equal '/login', path
  end

  test 'should be login with valid details' do
    get '/login'
    login_as(@user)
    follow_redirect!
    assert is_logged_in?
    assert_equal 200, status
    assert_equal '/', path
  end

  # Unauthenticate Tests
  test 'should redirect to login page if unauthenticated' do
    get '/'
    follow_redirect!
    assert_equal '/login', path
  end

  # Authenticated Tests
  test 'should be logout if authenticated' do
    # user login
    login_as(@user)
    follow_redirect!
    assert is_logged_in?
    assert_equal '/', path
    # user logout
    delete '/logout'
    follow_redirect!
    assert_not is_logged_in?
    assert_equal '/login', path
  end
end
