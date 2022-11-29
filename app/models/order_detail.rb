class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum making_status: { cannot_start: 0, waiting_make: 1, making: 2, make_completed: 3 }


end
