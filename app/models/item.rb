class Item < ApplicationRecord

  belongs_to :user
  belongs_to :category
  belongs_to :quality
  belongs_to :ship_load
  belongs_to :prefecture
  belongs_to :ship_day
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :category, numericality: { other_than: 1 } 
  validates :quality, numericality: { other_than: 1 } 
  validates :ship_load, numericality: { other_than: 1 } 
  validates :prefecture, numericality: { other_than: 1 } 
  validates :ship_day, numericality: { other_than: 1 } 
  validates :price, presence: true

end
