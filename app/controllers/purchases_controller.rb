class PurchasesController < ApplicationController

  before_action :item_find

  def index
    @purchase_delivery = PurchaseDelivery.new
  end

  def create
    @purchase_delivery = PurchaseDelivery.new(purchase_delivery_params)
      if @purchase_delivery.valid?
        @purchase_delivery.save
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

end
