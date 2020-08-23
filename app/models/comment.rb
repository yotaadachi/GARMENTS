class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :garment
	validates :body, presence: true
end
