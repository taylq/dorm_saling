class OrderDetail < ApplicationRecord
  acts_as_paranoid
  belongs_to :order, optional: true
  belongs_to :product, ->{with_deleted}
  belongs_to :cart

  def total_price
    quantity * product.price
  end
end
