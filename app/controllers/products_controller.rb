class ProductsController < ApplicationController
  attr_reader :product, :products, :categories, :search

  load_and_authorize_resource
  before_action :authenticate_user!

  before_action :reset_area, only: :index

  def index
    @categories = Category.all
    @search = Product.ransack params[:q]
    @products =
      if current_user.seller?
        current_user.products
      else
        search.result.product_by_time.product_by_area(current_user.area_id).product_by_category(@categories)
      end
  end

  def new
    @areas = Area.all
  end

  def create
    if product.save
      flash[:info] = t "create_succ"
      redirect_to products_path
    else
      flash.now[:warning] = t "create_fail"
      render :new
    end
  end

  def show; end

  def edit
    @areas = Area.all
  end

  def update
    if product.update_attributes product_params
      flash[:info] = t "update_succ"
      redirect_to products_path
    else
      flash.now[:warning] = t "update_fail"
      render :edit
    end
  end

  def destroy
    product.destroy
    flash[:success] = t "destroy_succ"
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit Product::ATTRIBUTE_PARAMS
  end

  def reset_area
    if Time.now.strftime("%H:%M:%S") >= "23:00:00"
      Product.product_auto_close.each do |product|
        product.areas_products.destroy_all
        product.areas_products.create(product_id: product.id,
          area_id: product.user.area_id)
      end
    end
  end
end
