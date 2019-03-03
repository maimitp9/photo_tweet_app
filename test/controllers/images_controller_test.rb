require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(user_name: 'test_user', password: 'test_password', password_confirmation: 'test_password')
    # @image = @user.images.build(title: 'photo_title', photo: upload_file("#{Rails.root}/public/img_1.jpeg"))
  end

  # Unauthenticate Tests
  test 'should not render index if unauthenticated' do
    get '/images'
    follow_redirect!
    assert_equal '/login', path
  end

  test 'should not render new if unauthenticated' do
    get '/images/new'
    follow_redirect!
    assert_equal '/login', path
  end

  # Authenticated Tests
  test 'should render new if authenticated' do
    login_as(@user)
    get '/images/new'
    assert_response :success
    assert_equal '/images/new', path
  end

  test 'should not create image with invalid details' do
    login_as(@user)
    get '/images/new'
    assert_response :success
    post '/images', params: { image: {title: ''}}
    assert_equal 200, status
    assert_select 'li', "#{I18n.t('activerecord.attributes.image.title')} #{I18n.t('activerecord.errors.models.image.attributes.title.blank')}"
    assert_select 'li', I18n.t('screen.images.errors.reuired_file')
  end

  test 'should not create image with title greater than 30 characters' do
    login_as(@user)
    get '/images/new'
    assert_response :success
    title = "m" * 31
    post '/images', params: { image: {title: title }}
    assert_equal 200, status
    assert_select 'li', "#{I18n.t('activerecord.attributes.image.title')} #{I18n.t('activerecord.errors.models.image.attributes.title.too_long')}"
  end
end
