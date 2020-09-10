class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #リレーション
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :garments, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_garments, through: :favorites, source: :garment

  #バリデーション
  validates :name, presence: true, length: { maximum: 30 }
  validates :introduction, length: { maximum: 200 }
  validates :email, presence: true

  # プロフィール画像
  mount_uploader :profile_image, ImageUploader

  # フォロー機能
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relaionships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relaionships, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def followings?(other_user)
    self.followings.include?(other_user)
  end

  #検索機能
  def User.search(word)
    User.where(["name LIKE?", "#{word}"])
  end

end