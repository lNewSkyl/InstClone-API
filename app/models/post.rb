class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  mount_uploaders :post_attachment, PostAttachmentUploader
  validates :title, presence: true
  validates :body, presence: true

end
