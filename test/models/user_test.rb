require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(user_name: "maimit_patel", password: "12345678", password_confirmation: '12345678')
  end

  test "should be valid" do
    assert @user.valid?
  end

  # ActiveRecord Validation Tests
  test "user_name should be present" do
    @user.user_name = " "
    assert_not @user.valid?
  end

  test "user_name should not be too long" do
    @user.user_name = "m" * 51
    assert_not @user.valid?
  end

  test "user_name should not contain white space" do
    invalid_user_names = ['maimit ','Maimit Patel']
    invalid_user_names.each do |invalid_user_name|
      @user.user_name = invalid_user_name
      assert_not @user.valid?, "#{invalid_user_name.inspect} should be invalid"
    end
  end

  test "user_name should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present(nonblank)" do
    @user.password = @user.password_confirmation = " " * 7
    assert_not @user.valid?
  end

  test "password should  have a minimum length" do
    @user.password = @user.password_confirmation = "m" * 5
    assert_not @user.valid?
  end

  # ActiveRecord Association Tests
  test "#images" do
    @user.save
    @user.images.create(title: 'image_1_title', photo: upload_file("#{Rails.root}/public/img_1.jpeg"))
    @user.images.create(title: 'image_2_title', photo: upload_file("#{Rails.root}/public/img_1.jpeg"))
    assert_equal 2, @user.images.size
  end
end
