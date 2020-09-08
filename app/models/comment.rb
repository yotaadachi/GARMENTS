class Comment < ApplicationRecord
	# リレーション
	belongs_to :user
	belongs_to :garment

	#バリデーション
	validates :body, presence: true
end
