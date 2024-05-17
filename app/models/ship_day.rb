#カラム名をスネークケースにしたが、モデルクラス名はアンダーバーなしのキャメルケースにしないといけない
#今後アソシエーションでエラーが出る様なら面倒なのでカラム名変えること
class ShipDay < ActiveHash::Base
  #発送までの日数
  self.data = [
    { id: 1, name: '---'},
    { id: 2, name: '1~2日で発送'},
    { id: 3, name: '2~3日で発送'},
    { id: 4, name: '4~7日で発送'}
  ]

  include ActiveHash::Associations
  has_many :items

 end