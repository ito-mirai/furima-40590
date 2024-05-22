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
      .merge(user_id: current_user.id, item_id: params[:item_id])
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

end
