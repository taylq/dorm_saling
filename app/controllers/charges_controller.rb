class ChargesController < ApplicationController
  rescue_from Stripe::CardError, with: :catch_exception
  attr_reader :order

  def new; end

  def create
    create_order
    StripeChargesServices.new(charges_params, current_user, current_cart).call
    redirect_to order_path order
  end

  private

  def charges_params
    params.permit :stripeEmail, :stripeToken
  end

  def catch_exception exception
    flash[:error] = exception.message
  end

  def order_params
    params.permit Order::ATTRIBUTE_PARAMS
  end

  def create_order
    @order = Order.new order_params
    current_cart.order_details.each do |item|
      order.order_details << item
    end
    order_save order
  end

  def order_save order
    if order.save
      flash[:success] = t "order_success"
    else
      flash[:danger] = t "create_fail"
    end
  end
end
