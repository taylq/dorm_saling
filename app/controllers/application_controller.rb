class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from CanCan::AccessDenied, with: :not_authorized

  before_action :set_locale, :current_cart

  class << self
    def default_url_options
      {locale: I18n.locale}
    end
  end

  private

  def current_cart
    if session[:cart_id]
      check_cart
    else
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def not_found
    flash[:danger] = t "controller.application.not_found"
    redirect_to root_path
  end

  def not_authorized
    flash[:danger] = t "controller.application.not_authorized"
    redirect_to root_path
  end

  def check_cart
    cart = Cart.find_by id: session[:cart_id]

    if cart.present?
      @current_cart = cart
    else
      session[:cart_id] = nil
    end
  end
end
