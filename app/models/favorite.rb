class Favorite < ApplicationRecord
  # リレーション
  belongs_to :user
  belongs_to :garment

  # バリデーション
  validates :user_id, uniqueness: { scope: :garment_id }
end
