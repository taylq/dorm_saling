class Product < ApplicationRecord
  acts_as_paranoid
  ATTRIBUTE_PARAMS =
    [
      :id, :name, :description, :user_id, :price, :picture, :category_id,
      :begin_at, :finish_at,
      areas_products_attributes: %i(id product_id area_id _destroy)
    ].freeze

  belongs_to :category
  belongs_to :user

  has_many :areas_products, dependent: :destroy
  has_many :areas, ->{distinct}, through: :areas_products, dependent: :destroy
  has_many :order_details, dependent: :destroy, as: :cart_order
  has_many :orders, through: :order_details, dependent: :destroy
  has_many :carts, through: :order_details, dependent: :destroy

  accepts_nested_attributes_for :areas_products, allow_destroy: true,
    reject_if: proc{|attributes| attributes["area_id"] == "0"}

  mount_uploader :picture, PictureUploader
  validate :picture_size
  validates :name, presence: true

  scope :product_by_time,
    ->{where "? BETWEEN begin_at AND finish_at", Time.zone.now}
  scope :product_by_area,
    ->(area_id){joins(:areas_products).where areas_products: {area_id: area_id}}
  scope :product_by_category,
    ->(category_id){where category_id: category_id}
  scope :product_by_seller_id,
    ->(user_id){where user_id: user_id}

  private

  def picture_size
    return unless picture.size > Settings.picture.size.megabytes
    errors.add :picture, t("size")
  end
end
