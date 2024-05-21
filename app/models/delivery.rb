class Delivery < ApplicationRecord
  belongs_to :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  # validates :post_code, presence: true
  # validates :prefecture_id, numericality: { other_than: 1 } 
  # validates :municipality, presence: true
  # validates :address, presence: true
  # validates :telephone, presence: true
end
