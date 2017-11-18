class Product < ApplicationRecord
  belong_to :category
  belong_to :user

  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details, dependent: :destroy
  has_many :product_areas, dependent: :destroy
  has_many :areas, through: :product_areas, dependent: :destroy
end
