class Admin::CustomersController < ApplicationController

  before_action :authenticate_admin!, except: [:admin_session_path]

  def index
    @customers = Customer.page(params[:page])
  end

  def show
     @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id), notice: "変更が完了しました"
    else
      flash.now[:error] = "空欄があります"
      render :edit
    end
  end

  def order_list
    @customer = Customer.find(params[:id])
    @orders = Order.where(customer_id: params[:id]).page(params[:page]).per(10)
    @sum_amount = 0
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end

end
