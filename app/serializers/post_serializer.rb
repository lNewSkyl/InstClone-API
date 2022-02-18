class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :body, :created_at, :updated_at, :post_attachment
  has_many :likes 
end
