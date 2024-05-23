class PurchasesController < ApplicationController
  # ＠itemに対して特定のitemレコードを代入
  before_action :item_find

  # ログインしていないとき、ログインページへ遷移する
  before_action :authenticate_user!

  # 購入不可のとき、トップページへ遷移する
  before_action :move_to_index

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_delivery = PurchaseDelivery.new
  end

  def create
    @purchase_delivery = PurchaseDelivery.new(purchase_delivery_params)
    if @purchase_delivery.valid?
      pay_item
      @purchase_delivery.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
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

  def move_to_index
    return unless (current_user == @item.user) || !@item.purchase.nil?

    redirect_to root_path
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,                    # 商品の値段
      card: purchase_delivery_params[:token], # カードトークン
      currency: 'jpy'                         # 通貨の種類（日本円）
    )
  end
end
