class Admin::OrdersController < ApplicationController

  before_action :require_admin

  def show
    @order = Order.find(params[:id])
  end

private

  def require_admin
    not_found unless logged_in? && current_user.admin?
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
