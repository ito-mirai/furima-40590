require 'rails_helper'

RSpec.describe PurchaseDelivery, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order = FactoryBot.build(:purchase_delivery, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  # 処理時間

  context '商品購入機能' do
    describe '正常系' do
      it '全てのフォームに対して適切に入力をしている' do
        expect(@order).to be_valid
      end
      it '建物名の入力がなくても保存される' do
        @order.building = nil
        expect(@order).to be_valid
      end
    end
    describe '異常系' do
      it 'ユーザー情報が紐づいていない' do
        @order.user_id = nil
        sleep 0.1
        @order.valid?
        expect(@order.errors.full_messages).to include("User can't be blank")
      end
      it '商品情報が紐づいていない' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end
      it 'カード情報が存在しない' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が入力されていない' do
        @order.post_code = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号にハイフンが含まれてない' do
        @order.post_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include('Post code is invalid')
      end
      it '郵便番号に全角文字列が含まれている' do
        @order.post_code = '１２３-４５６７'
        @order.valid?
        expect(@order.errors.full_messages).to include('Post code is invalid')
      end
      it '都道府県が選択されてない' do
        @order.prefecture_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県で「---」が選択されている' do
        @order.prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it '市区町村が入力されてない' do
        @order.municipality = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Municipality can't be blank")
      end
      it '番地が入力されていない' do
        @order.address = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が入力されていない' do
        @order.telephone = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Telephone can't be blank")
      end
      it '電話番号が9桁以下になっている' do
        @order.telephone = '000111222'
        @order.valid?
        expect(@order.errors.full_messages).to include('Telephone is invalid')
      end
      it '電話番号が12桁以上になっている' do
        @order.telephone = '000111222333'
        @order.valid?
        expect(@order.errors.full_messages).to include('Telephone is invalid')
      end
      it '電話番号にハイフンが含まれている' do
        @order.telephone = '000-1111-2222'
        @order.valid?
        expect(@order.errors.full_messages).to include('Telephone is invalid')
      end
      it '電話番号に全角文字列が入力されている' do
        @order.telephone = '０００１１１１２２２２'
        @order.valid?
        expect(@order.errors.full_messages).to include('Telephone is invalid')
      end
    end
  end
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
