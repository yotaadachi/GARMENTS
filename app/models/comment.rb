class Comment < ApplicationRecord
	# リレーション
	belongs_to :user
	belongs_to :garment

  #通知機能
  has_many :notifications, dependent: :destroy

	#バリデーション
	validates :body, presence: true, length: { maximum: 140 }
end
