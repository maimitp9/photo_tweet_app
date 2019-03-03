class User < ApplicationRecord
  # user_name can not be blank with maximum length should 50, without having space and it must be unique
  validates :user_name, presence: true, length: { maximum: 50 }, 
                        format: { without: /\s/ },
                        uniqueness: true
  has_secure_password
  # password can not be blank with minimum 6 character length
  validates :password, presence: true, length: { minimum: 6 }
  has_many :images
end
