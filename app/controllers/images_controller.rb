class ImagesController < ApplicationController
  before_action :set_image, only: :share

  # GET '/' (root_url)
  # list of images for logged_in user
  def index
    @images = Image.by_user(current_user).order_updated_at
  end

  # GET '/images/new'
  def new
    @image = Image.new
  end

  # POST '/images'
  def create
    @image = current_user.images.build(image_params)
    if @image.save
      redirect_to images_path, notice: I18n.t('success.images.created')
    else
      render :new
    end
  end

  # GET '/images/:image_id/share'
  # Tweet photo to remote server
  def share
    response = UnifaApi.call_post_api(api_url: PHOTO_TWEET, body: tweet_image,token: get_token)
    message = response.code == "201" ? I18n.t('success.images.share') : I18n.t('errors.images.share')
    redirect_to root_url, notice: message
  end

  private # PRIVATE METHODS
  # create or update strong params
  def image_params
    params.require(:image).permit(:title, :photo)
  end

  # return image record based on image_id
  def set_image
    @image = Image.find_by(id: params[:image_id])
  end

  # prepare the image json for API body
  def tweet_image
    {
      text: @image.try(:title),
      url: url_for(@image.photo)
    }
  end
end
