class PurchasesController < ApplicationController
  # ＠itemに対して特定のitemレコードを代入
  before_action :item_find

  # ログインしていないとき、ログインページへ遷移する
  before_action :move_to_sign_in

  # 購入不可のとき、トップページへ遷移する
  before_action :move_to_index

  def index
    @purchase_delivery = PurchaseDelivery.new
  end

  def create
    @purchase_delivery = PurchaseDelivery.new(purchase_delivery_params)
      if @purchase_delivery.valid?
        pay_item
        @purchase_delivery.save
        redirect_to root_path
      else
        render :index, status: :unprocessable_entity
      end
  end

  private

  def purchase_delivery_params
    params
      .require(:purchase_delivery)
      .permit(:post_code, :prefecture_id, :municipality, :address, :building, :telephone)
      .merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
  end

  def item_find
    @item = Item.find(params[:item_id])
  end

  def move_to_sign_in
    return if user_signed_in?

    redirect_to new_user_session_path
  end

  def move_to_index
    if (current_user == @item.user) || ( !@item.purchase.nil? )
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = "sk_test_4f7a96b84d7e6f81314aa12a"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,                    # 商品の値段
      card: purchase_delivery_params[:token], # カードトークン
      currency: 'jpy'                         # 通貨の種類（日本円）
    )
  end

end
