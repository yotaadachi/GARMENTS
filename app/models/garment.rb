class Garment < ApplicationRecord
	# リレーション
	belongs_to :user
	has_many :comments, dependent: :destroy

	#お気に入り機能
	has_many :favorites, dependent: :destroy

	#並びかえバー(お気に入りが多い順)
	ransacker :favorites_count do
		query = '(SELECT COUNT(favorites.garment_id) FROM favorites where favorites.garment_id = garments.id GROUP BY favorites.garment_id)'
		Arel.sql(query)
	end

	def favorite_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	# 各カラムバリデーション
	validates :title, presence: true, length: {minimum: 1}
	validates :body, presence: true
	validates :type, presence: true
	validates :image, presence: true
	validates :rate, presence: true
	validates :tag_list, presence: true

	# タグづけ機能
	acts_as_taggable

	# 新規投稿カテゴリ
	enum type:{
		トップス: 0, #トップス
		ジャケット: 1, #ジャケット
		パンツ: 2, #パンツ
		サロペット: 3, #サロペット
		スカート: 4, #スカート
		ワンピース: 5, #ワンピース
		スーツ: 6, #スーツ
		バッグ: 7, #バッグ
		シューズ: 8, #シューズ
		帽子: 9, #帽子
		その他: 10, #その他
	}
	# attr_accessible  :data, :type
	self.inheritance_column = :_type_disabled

	# 新規投稿星による評価
	validates :rate, numericality: {
		less_than_or_equal_to: 5,
		greater_than_or_equal_to: 1
	}, presence: true

   # 画像投稿機能
     mount_uploader :image, ImageUploader
end