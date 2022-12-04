class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!, except: [:admin_session_path]

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all

    is_updated = true
    if @order_detail.update(order_detail_params)
      @order.update(status: 2) if @order_detail.making_status == "making"
      @order_details.each do |order_detail|
        if order_detail.making_status != "make_completed"
          is_updated= false
        end
      end
      @order.update(status: 3) if is_updated
    end
    redirect_to admin_order_path(@order), notice: "制作ステータスを更新しました"
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
