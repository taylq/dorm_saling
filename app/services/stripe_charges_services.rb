class StripeChargesServices
  DEFAULT_CURRENCY = "usd".freeze

  def initialize params, user, order
    @stripe_email = params[:stripeEmail]
    @stripe_token = params[:stripeToken]
    @order = order
    @user = user
  end

  def call
    create_charge find_customer
  end

  private

  attr_accessor :user, :stripe_email, :stripe_token, :order

  def find_customer
    user_stripe_token = user.stripe_token
    if user_stripe_token
      retrieve_customer user_stripe_token
    else
      create_customer
    end
  end

  def retrieve_customer stripe_token
    Stripe::Customer.retrieve stripe_token
  end

  def create_customer
    customer = Stripe::Customer.create(
      email: stripe_email,
      source: stripe_token
    )
    user.update stripe_token: customer.id
    customer
  end

  def create_charge customer
    Stripe::Charge.create(
      customer: customer.id,
      amount: order.sub_total.to_i * 100,
      description: stripe_email,
      currency: DEFAULT_CURRENCY
    )
  end
end
