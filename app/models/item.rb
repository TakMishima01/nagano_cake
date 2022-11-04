class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
end
  def add_tax_price
    (@item.price * 1.10).round
  end

  def show_status
    if (@item.is_active) == "ture"
      "販売中"
    else
      "販売停止中"
    end
  end