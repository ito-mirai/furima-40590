class ItemsController < ApplicationController
  # ＠itemに対して特定のitemレコードを代入
  before_action :item_find, only: [:show, :edit, :update, :destroy]

  # ログインしていないとき、ログインページへ遷移する
  before_action :move_to_sign_in, only: [:new, :edit, :destroy]

  # 操作権がないとき、トップページへ遷移する
  before_action :move_to_index, only: [:edit, :destroy]

  # 売買済みのとき、トップページへ遷移する
  before_action :sold_out, only: :edit

  def index
    @items = Item.all.order('created_at DESC')
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

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(params[:id])
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params
      .require(:item)
      .permit(:image, :name, :description, :category_id, :quality_id, :ship_load_id, :prefecture_id, :ship_day_id, :price)
      .merge(user_id: current_user.id)
  end

  def item_find
    @item = Item.find(params[:id])
  end

  def move_to_sign_in
    return if user_signed_in?

    redirect_to new_user_session_path
  end

  def move_to_index
    return if current_user == @item.user

    redirect_to root_path
  end

  def sold_out
    return if @item.purchase.nil?

    redirect_to root_path
  end
end
