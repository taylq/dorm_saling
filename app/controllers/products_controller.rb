class ProductsController < ApplicationController
  attr_reader :product, :products

  load_and_authorize_resource

  def index
    @products = Product.where("begin_at < '#{Time.now}' and '#{Time.now}' < finish_at")
  end

  def new
    @areas = Area.all
  end

  def create
    if product.save
      flash[:info] = t "create_succ"
      redirect_to products_path
    else
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
    params.require(:product).permit Product::ATTRIBUTE_PARAMS,
      areas_products_attributes: %i(id product_id area_id _destroy)
  end
end
