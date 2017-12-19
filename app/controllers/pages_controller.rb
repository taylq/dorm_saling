class PagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @categories = Category.all
    @products = Product.product_by_time.product_by_area(current_user.area_id).product_by_category(@categories)
    if valid_page?
      render "pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private

  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
  end
end
