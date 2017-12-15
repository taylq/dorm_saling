class Cart < ApplicationRecord
  belongs_to :user

  has_many :order_details, dependent: :destroy, as: :cart_order
  has_many :products, through: :order_details, dependent: :destroy

  def sub_total
    sum = 0
    order_details.each do |line_item|
      sum += line_item.total_price
    end
    sum
  end
end
