class Public::ItemsController < ApplicationController

  def index
    @genres = Genre.all
    @title = "商品"
    @items_count = Item.count
    @items = Item.page(params[:page]).per(8)

    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @title = @genre.name
      @items_count = @genre.items.count
      @items = @genre.items.page(params[:page]).per(8)
    end
  end

  def search
  end



  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @customer = current_customer
  end



end
