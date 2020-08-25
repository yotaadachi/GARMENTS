class Favorite < ApplicationRecord
	belongs_to :user
	belongs_to :garment

	validates :user_id, uniqueness: { scope: :garment_id }
end
