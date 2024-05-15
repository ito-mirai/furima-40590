class Item < ApplicationRecord

  belongs_to :user
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :quality_id, presence: true
  validates :ship_load_id, presence: true
  validates :prefecture_id, presence: true
  validates :ship_day_id, presence: true
  validates :price, presence: true

end
