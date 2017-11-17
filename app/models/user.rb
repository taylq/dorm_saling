class User < ApplicationRecord
  enum position: %i(admin seller user)

  belong_to :area

  has_many :orders, dependent: :destroy
  has_many :products, dependent: :destroy
end
