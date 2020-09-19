class Relationship < ApplicationRecord
  # リレーション
  belongs_to :user
  belongs_to :follow, class_name: 'User'

  # バリデーション
  validates :user_id, presence: true
  validates :follow_id, presence: true
  validates :follow_id, uniqueness: { scope: :user_id }
end
