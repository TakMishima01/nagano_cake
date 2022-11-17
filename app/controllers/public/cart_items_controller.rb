class Public::CartItemsController < ApplicationController

  def index
  end

  def update
  end

  def destroy
  end

  def destory_all
  end

  def create
    cart_item = CartItem.new
    cart_item.save
    redirect_to cart_items_path
  end

end
