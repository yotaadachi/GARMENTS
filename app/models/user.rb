class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :garments, dependent: :destroy
  has_many :comments, dependent: :destroy

  # プロフィール画像
     mount_uploader :profile_image, ImageUploader
end
