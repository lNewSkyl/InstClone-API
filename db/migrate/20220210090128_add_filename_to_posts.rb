class AddFilenameToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :post_attachment, :string
  end
end
