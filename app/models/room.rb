class Room < ApplicationRecord
  belongs_to :user
  has_one_attached :image #施設用の写真を1枚持つ
end
