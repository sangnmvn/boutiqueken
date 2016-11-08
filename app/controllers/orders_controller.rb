class OrdersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout "devise"
  before_filter :authenticate_user!
  before_filter :check_user_orders, only: [:show,:confirm,:confirmed,:payment]

  def create
  	@success = false
    @order = Order.new(order_params.merge({user_id: current_user.id}))
    @success = @order.save
    if @success && @order.parse_items_from_cart(@shopping_cart)
      redirect_to payment_order_path(@order)
    end
    
    if current_user.addresses.count ==0
      current_user.add_default_address(params[:order][:shipping_address_attributes],params[:order][:billing_address_attributes])
    end


  end

  def show
    @order = Order.find(params[:id])
    @billing = @order.billing_address
    @shipping = @order.shipping_address
  end

  def payment
    @order = Order.find(params[:id])
  end
  
  def confirm
    @order = Order.find(params[:id])
    @billing = @order.billing_address
    @shipping = @order.shipping_address
  end

  def confirmed
    @order = Order.find(params[:id])
    @order.update_attributes({:status =>1})
    @shopping_cart.clear
    redirect_to orders_user_path(current_user)
  end

  protected
  def order_params
    params[:order][:shipping_address_attributes].merge!({user_id: current_user.id})
    params[:order][:billing_address_attributes].merge!({user_id: current_user.id})
    if params[:order][:shipping_address_attributes][:is_default_billing] == true || params[:order][:shipping_address_attributes][:is_default_billing] == "1"
      params[:order][:billing_address_attributes] = params[:order][:shipping_address_attributes]
      params[:order][:billing_address_attributes][:is_default_billing] = "0"
    end
  	params.require(:order).permit(:email,:phone,:shipping_address_attributes =>[:first_name,:last_name,:company_name,:telephone, :fax,:street_address,:street_address2,:city,:state,:zip_code,:country,:is_default_billing,:is_default_shipping,:shipping_address_id,:order_id,:user_id,:address_type,:country],
      :billing_address_attributes =>[:first_name,:last_name,:company_name,:telephone, :fax,:street_address,:street_address2,:city,:state,:zip_code,:country,:is_default_billing,:is_default_shipping,:billing_address_id,:user_id,:order_id,:address_type,:country]).permit!  
  end

  def check_user_orders
    existed = current_user.orders.where(:id => params[:id]).first
    redirect_to root_path and return if existed.blank?
  end
end