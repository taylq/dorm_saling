class Order < ApplicationRecord
  enum status: %i(accept refuse)

  belongs_to :user

  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details, dependent: :destroy
end
