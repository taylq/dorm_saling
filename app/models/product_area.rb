class ProductArea < ApplicationRecord
  belong_to :area
  belong_to :product
end
