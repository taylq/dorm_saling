class User < ApplicationRecord
  enum position: %i(admin seller user)

  ATTRIBUTE_PARAMS =
    %i(
      name email room phone area_id password password_confirmation position
    ).freeze

  belongs_to :area

  has_many :orders, dependent: :destroy
  has_many :products, dependent: :destroy
  has_one :cart, dependent: :destroy

  accepts_nested_attributes_for :cart

  devise :database_authenticatable, :registerable,
    :rememberable, :validatable, :confirmable

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
end
