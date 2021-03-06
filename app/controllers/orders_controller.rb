class OrdersController < ApplicationController
  before_action :require_login

  def show
    if current_user.orders.include?(Order.find(params[:id]))
      @order = current_user.orders.find(params[:id])
    else
      render_404
    end
  end

  def index
    @orders = current_user.orders
  end

  def create
    order = checkout_items
    if order.save
      flash[:success] = "Order was successfully placed"
      redirect_to orders_path
    else
      flash[:danger] = "Unable to create order"
      redirect_to cart_path
    end
  end

  def update
    @orders = Order.update(params[:id], status: params[:status])
    redirect_back(fallback_location: admin_dashboard_path)
  end

private

  def order_params
    params.require(:order).permit(:original_address, :original_purchaser)
  end

  def checkout_items
    order = current_user.orders.new(original_address: current_user.address)
    set_cart.contents.each do |key, value|
      order.order_items.new(
        item_id: key.to_i,
        original_unit_price: Item.find(key.to_i).unit_price,
        original_unit: Item.find(key.to_i).unit,
        quantity: value
      )
    end
    order
  end


end
