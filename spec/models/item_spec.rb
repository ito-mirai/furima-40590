require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context '商品出品機能' do
    describe '正常系' do
      it '適切な情報を全て入力している' do
        expect(@item).to be_valid
      end
    end
    describe '異常系' do
      it '商品画像が1枚は必須' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が必須' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明が必須' do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーの情報が必須' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category is not a number")
      end
      it 'カテゴリーの情報で「---」は保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it '商品の状態の情報が必須' do
        @item.quality_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Quality is not a number")
      end
      it '商品の状態で「---」は保存できない' do
        @item.quality_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Quality must be other than 1")
      end
      it '配送料の負担の情報が必須' do
        @item.ship_load_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship load is not a number")
      end
      it '配送料の負担で「---」は保存できない' do
        @item.ship_load_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship load must be other than 1")
      end
      it '発送元の地域の情報が必須' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture is not a number")
      end
      it '発送元の地域で「---」は保存できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it '発送までの日数の情報が必須' do
        @item.ship_day_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship day is not a number")
      end
      it '発送までの日数で「---」は保存できない' do
        @item.ship_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship day must be other than 1")
      end
      it '価格の情報が必須' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格は¥300以上でないといけない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be in 300..9999999")
      end
      it '価格は¥9,999,999以下でないといけない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be in 300..9999999")
      end
      it '価格は全角数字で保存できない' do
        @item.price = "１０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格は半角英字で保存できない' do
        @item.price = "price"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end
  end
  
end
