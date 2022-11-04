class Admin::ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
    @genre = Genre.all
  end

  def create
    item = Item.new(item_params)
    item.save
    redirect_to admin_item_path(item)
  end

  def show
    @item = Item.find(params[:id])
    @add_tax = @item.price * 1.1.ceil
  end

  def edit
  end

  def update
  end
  
  private

  def item_params
    params.require(:item).permit(:image, :genre_id, :name, :introduction, :price, :is_active)
  end

end
