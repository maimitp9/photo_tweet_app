class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]
  before_action :validate_params, only: :create
  
  # GET '/login'
  # return root_path is user logged_in? otherwise return to login 
  def new
    redirect_to root_path if logged_in?
  end

  # POST '/login', login the requested user if authenticate
  # set session if login success otherwise retuen to login
  def create
    user = User.find_by(user_name: params[:session][:user_name])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path
    else
      flash[:error] = I18n.t('errors.log_in.create')
      render :new
    end
  end

  # DELETE '/logout', logout current_user
  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

  private # PRIVATE METHODS

  # validate pramameters for log in
  def validate_params
    @user =  Validation::LogIn.new(params[:session])
    if !@user.valid?
      flash[:error] = ""
      render :new
    end
  end
end
