class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
  end

  def confirm
    @order = Order.new(order_params)

    # ご自身の住所を選択
    if params[:order][:select_address] == "0" then
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name+current_customer.first_name

    # 登録済み住所を選択
    elsif params[:order][:select_address] == "1" then
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    # 新しい住所を選択
    else

    end

    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = 0
    @order.shipping_cost = 800
  end

  def complete
  end

  def create
    # 注文情報の保存
    order = Order.new(order_params)
    order.save
    # 注文詳細情報の保存
    cart_items = current_customer.cart_items.all
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item.id
      order_detail.order_id = order.id
      order_detail.purchase_price_tax = cart_item.item.add_tax_price
      order_detail.amount = cart_item.amount
      order_detail.save
    end

    current_customer.cart_items.destroy_all

    redirect_to orders_complete_path
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
    @order_details = OrderDetail.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.all

  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :customer_id, :shipping_cost, :total_payment)
  end

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :purchase_price_tax, :amount)
  end

end
