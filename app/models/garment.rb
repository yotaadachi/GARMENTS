class Garment < ApplicationRecord
	# リレーション
	belongs_to :user
	has_many :comments, dependent: :destroy

	#お気に入り機能
	has_many :favorites, dependent: :destroy

	#通知機能
	has_many :notifications, dependent: :destroy

	def create_notification_by(current_user)
		notification = current_user.active_notifications.new(
				garment_id: id,
				visited_id: user_id,
				action: "favorite"
			)
		notification.save if notification.valid?
	end

	def create_notification_comment!(current_user, comment_id)
		#自分以外のコメントしている全てのユーザーに通知を送る
		temp_ids = Comment.select(:user_id).where(garment_id: id).where.not(user_id: current_user.id).distinct
		temp_ids.each do |temp_id|
			save_notification_comment!(current_user, comment_id, temp_id['user_id'])
		end
		#誰もコメントしていない場合は、投稿者に通知を送る
		save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
	end

	def save_notification_comment!(current_user, comment_id, visited_id)
		#コメントは複数できるので、一つの投稿に対して複数回通知する
		notification = current_user.active_notifications.new(
				garment_id: id,
				comment_id: comment_id,
				visited_id: visited_id,
				action: "comment"
			)
		#自分の投稿に対するコメントの場合は通知済みとする
		if notification.visiter_id == notification.visited_id
			notification.checked = true
		end
		 notification.save if notification.valid?
	end

	# バリデーション
	validates :title, presence: true
	validates :body, presence: true, length: { maximum: 200 }
	validates :type, presence: true
	validates :image, presence: true
	validates :rate, presence: true
	validates :tag_list, presence: true

	#並びかえバー(お気に入りが多い順)
	ransacker :favorites_count do
		query = '(SELECT COUNT(favorites.garment_id) FROM favorites where favorites.garment_id = garments.id GROUP BY favorites.garment_id)'
		Arel.sql(query)
	end

	def favorite_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	# タグづけ機能
	acts_as_taggable

	# 新規投稿カテゴリ
	enum type:{
		トップス: 0, #トップス
		ジャケット: 1, #ジャケット
		パンツ: 2, #パンツ
		スカート: 3, #スカート
		ワンピース: 4, #ワンピース
		スーツ: 5, #スーツ
		バッグ: 6, #バッグ
		シューズ: 7, #シューズ
		帽子: 8, #帽子
		時計: 9, #時計
		アクセサリー: 10, #アクセサリー
		その他: 11, #その他
	}

	self.inheritance_column = :_type_disabled

	# 新規投稿星による評価
	validates :rate, numericality: {
		less_than_or_equal_to: 5,
		greater_than_or_equal_to: 1
	}, presence: true

  # 画像投稿機能
    mount_uploader :image, ImageUploader

  # 検索機能
   	def Garment.search(word)
      Garment.where(["title LIKE?", "#{word}"])
    end

end