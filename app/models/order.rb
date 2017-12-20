class Order < ApplicationRecord
  enum status: %i(accept waiting not_done)
  enum status_payment: %i(paid unpaid)

  belongs_to :user

  has_many :order_details, dependent: :destroy, as: :cart_order
  has_many :products, through: :order_details, dependent: :destroy

  accepts_nested_attributes_for :order_details, allow_destroy: true

  ATTRIBUTE_PARAMS = %i(user_id status status_payment).freeze

  scope :shopping_cart, ->(user_id){where(user_id: user_id)}
  scope :order_paid, ->{where(status_payment: :paid)}
  scope :order_unpaid, ->{where(status_payment: :unpaid)}

  def sub_total
    sum = 0
    order_details.each do |line_item|
      sum += line_item.total_price
    end
    sum
  end
end
