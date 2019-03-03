module Validation
  class LogIn
    include ActiveModel::Validations
    attr_accessor :user_name, :password

    validates :user_name, presence: true
    validates :password, presence: true

    def initialize(params={})
      @user_name  = params[:user_name]
      @password = params[:password]
      params.permit(:user_name,:password)
    end
  end
end