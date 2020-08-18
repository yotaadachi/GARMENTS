class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :type_id
      t.string :title
      t.string :body
      t.string :image_id
      t.float :rate

      t.timestamps
    end
  end
end
