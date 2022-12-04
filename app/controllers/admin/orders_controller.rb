class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!, except: [:admin_session_path]

  def index
    @orders = Order.page(params[:page])
    @sum_amount = 0

  end


  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
    if @order.update(order_params)
      @order_details.update_all(making_status: 1) if @order.status == "payment_confirmed"
    end
    redirect_to admin_order_path(@order), notice: "注文ステータスを更新しました"
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end


end
