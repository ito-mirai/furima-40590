class PurchaseDelivery
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :municipality, :address, :building, :telephone, :purchase_id
  
  #バリデーションを記述
  with_options presence: do
    validates :user_id
    validates :item_id
    validates :post_code
    validates :prefecture_id, numericality: { other_than: 1 } 
    validates :municipality
    validates :address
    validates :telephone
    # validates :purchase_id
  end
  
  #なおアソシエーションを定義することは出来ないため、belongs_toによるバリデーションは行えない
  #そのため普通のバリデーションとして記述する必要がある
  
  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Delivery.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, address: address, building: building, telephone: telephone, purchase_id: purchase.id)
  end
  
end