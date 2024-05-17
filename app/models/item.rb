class Item < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :quality
  belongs_to :ship_load
  belongs_to :prefecture
  belongs_to :ship_day

  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, numericality: { other_than: 1 } 
  validates :quality_id, numericality: { other_than: 1 } 
  validates :ship_load_id, numericality: { other_than: 1 } 
  validates :prefecture_id, numericality: { other_than: 1 } 
  validates :ship_day_id, numericality: { other_than: 1 } 
  validates :price, numericality: { only_integer: true, in: 300..9999999 }

end
