class Room < ApplicationRecord
  belongs_to :user
  has_one_attached :image #施設用の写真を1枚持つ

  validates :name, :description, :price, :address, presence: true

  #宿泊料金は、数値、整数、1以上を条件とする
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
