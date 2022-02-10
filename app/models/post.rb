class Post < ApplicationRecord
  mount_uploaders :post_attachment, PostAttachmentUploader
  validates :title, presence: true
  validates :body, presence: true
end
