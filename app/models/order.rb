class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting_payment: 0, payment_confirmed: 1, making: 2, shipping_preparation: 3, sent: 4 }
  

  def subtotal
    item.add_tax_price*amount
  end
end
