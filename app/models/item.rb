class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
end
  def add_tax_price
    (@item.price * 1.10).round
  end