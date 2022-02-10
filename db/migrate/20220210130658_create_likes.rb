class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.bigint :post_id
      t.bigint :user_id
      t.boolean :liked

      t.timestamps
    end
  end
end
