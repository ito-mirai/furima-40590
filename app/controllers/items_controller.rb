class ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
    redirect_to root_path
  end

  private

  def item_params
    params.require(
            :item
          ).
          permit(
            :image, :name, :description, :category_id, :quality_id, :ship_load_id, :prefecture_id, :ship_day_id, :price 
          ).
          merge(
            user_id: current_user.id
          )
  end

end
