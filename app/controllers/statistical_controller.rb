class StatisticalController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.js{render json: load_data_chart}
    end
  end

  def load_data_chart
    order_by_date = []
    order_paid_by_date = []
    order_unpaid_by_date = []
    amount_by_date = []
    result_date = []

    order = Order.where("id in (select cart_order_id from order_details where product_id in (select id from products where user_id = #{current_user.id}))")
    order_by_date = [0, 10, 12, 16, 13, 18, 14, 19, 15, 18, 11, order.count]
    order_paid_by_date = [0, 3, 6, 6, 10, 8, 10, 12, 8, 13, 4, order.order_paid.count]
    order_unpaid_by_date = [0, 7, 6, 10, 3, 10, 4, 7, 7, 5, 7, order.order_unpaid.count]
    amount = OrderDetail.order_of_seller(current_user.id)
    amount_by_date = [0, 300000, 320000, 500000, 400000, 520000, 480000, 600000, 550000, 580000, 110000, amount.sum("quantity * product_price").to_i]
    result_date = order.group_by_month_of_year(:created_at).count.keys

    {
      order_by_date: order_by_date,
      order_paid_by_date: order_paid_by_date,
      order_unpaid_by_date: order_unpaid_by_date,
      amount_by_date: amount_by_date,
      result_date: result_date
    }
  end
end
