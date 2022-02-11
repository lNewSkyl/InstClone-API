class User < ApplicationRecord
  include UserHelper
  has_secure_password
  mount_uploader :user_image, UserImageUploader
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
end
