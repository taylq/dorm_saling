class OrdersController < ApplicationController
  attr_reader :order, :orders

  load_and_authorize_resource

  def index
    @orders = Order.all
  end

  def new; end

  def create
    if order.save
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js
      end
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if order.update_attributes order_params
      flash[:info] = t "update_succ"
      redirect_to orders_path
    else
      render :edit
    end
  end

  def destroy
    order.destroy
    flash[:success] = t "destroy_succ"
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit Order::ATTRIBUTE_PARAMS,
      order_details_attributes: %i(id order_id product_id quantity)
  end
end
