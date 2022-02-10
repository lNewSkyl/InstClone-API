class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy 
  mount_uploaders :post_attachment, PostAttachmentUploader
  validates :title, presence: true
  validates :body, presence: true

  def liked_by(user)
    Like.find_by(user_id: user.id, post_id: id)
  end
end
