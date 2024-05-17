class ItemsController < ApplicationController

  #ログインしていないとき、ログインページへ遷移する
  before_action :move_to_sign_in, only: :new

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params
      .require(:item)
      .permit(:image, :name, :description, :category_id, :quality_id, :ship_load_id, :prefecture_id, :ship_day_id, :price )
      .merge(user_id: current_user.id)
  end

  def move_to_sign_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

end
