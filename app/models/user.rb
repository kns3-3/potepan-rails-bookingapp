class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true #名前の入力は必須

  has_one_attached :image #「image」という名前で1枚の画像を持てるようにす
  
  has_many :rooms, dependent: :destroy #1人のユーザは複数の施設をもつ/ユーザー削除時に、紐付く施設も削除する
end
