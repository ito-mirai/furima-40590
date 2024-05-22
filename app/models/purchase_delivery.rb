class PurchaseDelivery
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :post_code, :prefecture_id, :municipality, :address, :building, :telephone,
                :purchase_id

  with_options presence: do
    validates :token
    validates :user_id
    validates :item_id
    validates :post_code, format: /\A[0-9]{3}-[0-9]{4}\z/
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :municipality
    validates :address
    validates :telephone, format: /\A[0-9]{10,11}\z/
  end

  def save
    purchase = Purchase.create(user_id:, item_id:)
    Delivery.create(post_code:, prefecture_id:, municipality:, address:,
                    building:, telephone:, purchase_id: purchase.id)
  end
end
