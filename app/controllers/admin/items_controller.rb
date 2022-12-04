class Admin::ItemsController < ApplicationController

  before_action :authenticate_admin!, except: [:admin_session_path]

  def index
    @items = Item.page(params[:page])



  end

  def new
    @item = Item.new
    @genre = Genre.all
  end

  def create
    new
    item = Item.new(item_params)
    if item.save
      redirect_to admin_item_path(item), notice:  "登録が完了しました"
    else
      flash.now[:error] = "空欄があります"
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @add_tax = (@item.price*1.1).floor
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id), notice: "変更が完了しました"
    else
      flash.now[:error] = "空欄があります"
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :genre_id, :name, :introduction, :price, :is_active)
  end

end
