class CreateGarments < ActiveRecord::Migration[5.2]
  def change
    create_table :garments do |t|
      t.integer :user_id
      t.integer :type_id
      t.string :title, null: :false
      t.string :body, null: :false
      t.integer :type, null: :false, limit: 1
      t.string :image, null: :false
      t.float :rate

      t.timestamps
    end
  end
end
