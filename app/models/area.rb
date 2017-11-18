class Area < ApplicationRecord
  has_many :product_areas, dependent: :destroy
  has_many :products, through: :product_areas, dependent: :destroy
  has_many :users, dependent: :destroy
end
