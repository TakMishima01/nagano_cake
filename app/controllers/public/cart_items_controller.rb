class Public::CartItemsController < ApplicationController

  def index
  end

  def create
    binding.pry
    @item = Item.find(cart_item_params[:item_id])

  end

  def update
  end

  def destroy
  end

  def destory_all
  end

 private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end


end
