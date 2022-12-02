class Public::AddressesController < ApplicationController

  before_action :authenticate_customer!, except: [:top]

  def index
    @address = Address.new
    @addresses = Address.all
  end

  def create
    index
    address = Address.new(address_params)
    address.customer_id = current_customer.id
    if address.save
      redirect_to addresses_path, notice: "登録が完了しました"
    else
      flash.now[:error] = "空欄があります"
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
    redirect_to addresses_path, notice: "変更が完了しました"
  else
    flash.now[:error] = "空欄があります"
    render :edit
  end

  end

  def destroy
    address = Address.find(params[:id])
    if address.customer_id == current_customer.id
      address.destroy
    end
    redirect_to addresses_path, notice: "削除しました"
  end


 private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end


end
