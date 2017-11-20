class ProductArea < ApplicationRecord
  belongs_to :area
  belongs_to :product
end
