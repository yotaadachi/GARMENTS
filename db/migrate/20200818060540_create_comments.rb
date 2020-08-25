class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.integer :garment_id, foreign_key: true, null: false
      t.string :body, null: false

      t.timestamps
    end
  end
end
