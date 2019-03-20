require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def setup
    @user = User.create(user_name: 'maimit_patel', password: '12345678', password_confirmation: '12345678')
    @image = @user.images.build(title: 'photo_title', photo: upload_file("#{Rails.root}/public/img_1.jpeg"), created_at: DateTime.now()-2, updated_at: DateTime.now()-2)
    @image_1 = @user.images.create(title: 'created_now', photo: upload_file("#{Rails.root}/public/img_1.jpeg"))
  end

  # ActiveRecord Validation Tests
  test "should be valid" do
    assert @image.valid?
  end

  test "title should be present" do
    @image.title = " "
    assert_not @image.valid?
  end

  test "title should not be greate then 30 characters" do
    @image.title = "m" * 31
    assert_not @image.valid?
  end

  test "photo should be present" do
    @image.photo.purge
    assert_not @image.valid?
  end

  # ActiveRecord Association Tests
  test "#user" do
    @image.save
    assert_equal @user.id, @image.user.id
  end

  # Scope Tests
  test "#by_user -> list current user photos" do
    @image.save
    other_user = User.create(user_name: 'other_user', password: '12345678', password_confirmation: '12345678')
    other_user.images.create(title: 'other_user_photo', photo: upload_file("#{Rails.root}/public/img_1.jpeg"))
    list = Image.by_user(@user)
    assert_equal 2, list.size
    assert_not_equal other_user.id, list.first.user_id
  end

  test "#order_updated_at -> order by updated_at" do
    @image.save
    list = Image.by_user(@user)
    assert_equal list.first.id, @image_1.id
  end
end
