class ProductsController < ApplicationController
  attr_reader :product, :products

  load_and_authorize_resource

  def index
    @products = Product.product_by_time
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
end