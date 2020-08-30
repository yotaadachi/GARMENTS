class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :user, type: :bigint, foreign_key: true, null: false
      t.references :garment, type: :bigint, foreign_key: true, null: false

      t.timestamps
      t.index [:user_id, :garment_id], unique: true
    end
  end
end
