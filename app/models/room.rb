class Room < ApplicationRecord
  belongs_to :user
  has_one_attached :image #施設用の写真を1枚持つ

  validates :name, :description, :price, :address, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 } #金額の登録は1円以上
end
