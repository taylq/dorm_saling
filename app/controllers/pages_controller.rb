class PagesController < ApplicationController
  def show
    @products = Product.where("begin_at < '#{Time.now}' and '#{Time.now}' < finish_at")
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
