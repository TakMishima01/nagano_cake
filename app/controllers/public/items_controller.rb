class Public::ItemsController < ApplicationController

  def index
    @genres = Genre.all
    if params[:q].blank? && params[:genre_id].blank?
      @title = "商品"
      @items_count = @search_items.count
      @items = @search_view
    elsif params[:q].present? && params[:genre_id].blank?
      @title = "検索結果"
      @items_count = @search_items.count
      @items = @search_view
    else params[:q].blank? && params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @title = @genre.name
      @items_count = @genre.items.count
      @items = @genre.items.where(is_active: 1).page(params[:page]).per(8)
    end
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
