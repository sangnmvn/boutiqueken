class OrdersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout "devise"
  before_filter :authenticate_user!
  

  def create
  	@success = false
    @order = Order.new(order_params.merge({user_id: current_user.id}))
    @success = @order.save
    if @success && @order.parse_items_from_cart(@shopping_cart)
      redirect_to payment_order_path(@order)
    end



  end

  def payment
    
  end
  
  protected
  def order_params
    params[:order][:shipping_address_attributes].merge!({user_id: current_user.id})
    params[:order][:billing_address_attributes].merge!({user_id: current_user.id})
  	params.require(:order).permit(:email,:phone,:shipping_address_attributes =>[:first_name,:last_name,:company_name,:telephone, :fax,:street_address,:street_address2,:city,:state,:zip_code,:country,:is_default_billing,:is_default_shipping],
      :billing_address_attributes =>[:first_name,:last_name,:company_name,:telephone, :fax,:street_address,:street_address2,:city,:state,:zip_code,:country,:is_default_billing,:is_default_shipping])  
  end
end