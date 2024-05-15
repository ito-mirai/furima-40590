class ItemsController < ApplicationController

  def index
  end

  def new
    Item.new(item_params)
  end

  def create
  end

  private

  def item_params
    params.require(
            :item
          ).
          permit(
            :name, :description, :category_id, :quality_id, :ship_load_id, :prefecture_id, :ship_day_id, :price 
          ).
          merge(
            user_id: current_user.id
          )
  end

end
