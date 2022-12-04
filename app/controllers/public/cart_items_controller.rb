class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!, except: [:top]

  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = 0
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      if cart_item.item_id == @cart_item.item_id
        new_amount = cart_item.amount + @cart_item.amount
        cart_item.update_attribute(:amount, new_amount)
        @cart_item.delete
      end
    end
    @cart_item.save
    redirect_to cart_items_path, notice: "カートに商品が入りました"
  end

  def update
    @item_amount = CartItem.find(params[:id])
    @item_amount.update(cart_item_params)
    redirect_to cart_items_path, notice: "変更が完了しました"
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.delete
    redirect_to cart_items_path, notice: "アイテムを削除しました"
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: "カートを空にしました"
  end

# private
#   def cart_item_params
#     params.require(:cart_item).permit(:customer_id, :item_id, :amount)
#   end

 private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
