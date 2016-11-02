class ShoppingCartsController < ApplicationController
  #before_filter :extract_shopping_cart
  layout "devise"
  before_filter :authenticate_user!, :only =>[:billing]
  def create
    if params[:has_color].present? && (params[:has_color] == true || params[:has_color] == "true")
      @product = ProductPriceDetail.find(params[:detail_id])
      @success = false and return if @product.blank?
      quantity = params[:quantity] || 1
      @success = true
      if @product.require_size == true && params[:size].blank?
        @success = false
      else
        if params[:size].present?
          is_existed = @shopping_cart.shopping_cart_items.where(:item_id =>@product.id,:size => params[:size]).first
          if is_existed
            is_existed.quantity += quantity;
            is_existed.save
          else
            item = @shopping_cart.shopping_cart_items.create(item: @product, price: @product.get_price, quantity: quantity,size: params[:size])

          end
        else
          item = @shopping_cart.add(@product, @product.get_price,quantity)
        end
      end
    else
      @product = Product.find(params[:detail_id])
      @success = false and return if @product.blank?
      quantity = params[:quantity] || 1
      @success = true
      if @product.list_sizes.present? && params[:size].blank?
        @success = false
      else
        if params[:size].present?
          is_existed = @shopping_cart.shopping_cart_items.where(:item_id =>@product.id,:size => params[:size],:has_color => false).first
          if is_existed
            is_existed.quantity += quantity;
            is_existed.save
          else
            item = @shopping_cart.shopping_cart_items.create(item: @product, price: @product.sale_price, quantity: quantity,size: params[:size],:has_color => false)

          end
        else
          item = @shopping_cart.add(@product, @product.sale_price,quantity)
        end
      end
    end
    
    
    
    
    if request.xhr?
      
    else
      redirect_to shopping_carts_path
    end
  end

  def show
    # @product_detail = ProductPriceDetail.find(@shopping_cart.item_id)
    # @product = @product_detail.product
    
  end

  def update
    @item = @shopping_cart.shopping_cart_items.where(:id => params[:item_id]).first
    @success = true
    if @item.present? && params[:shopping_cart_item][:quantity].present?
      @success = @item.update_attributes({:quantity => params[:shopping_cart_item][:quantity]})
    else
      @success = false
    end
  end


  def destroy
    @item = @shopping_cart.shopping_cart_items.where(:id => params[:item_id]).first
    @success = true
    if @item.present?
      @success = @item.destroy
    else
      @success = false
    end
  end


  def billing
    @default_billing = current_user.default_billing_address
    @default_shipping = current_user.default_shipping_address
    @order = Order.new({:user_id => current_user.id})
    if @default_shipping.present?
      @order.build_shipping_address(@default_shipping.dup.attributes)
    else
      @order.build_shipping_address
    end

    if @default_billing.present?
      @order.build_billing_address(@default_billing.dup.attributes)
    else
      @order.build_billing_address
    end

  end

  def payment
  end

  private
  def extract_shopping_cart
    shopping_cart_id = session[:shopping_cart_id]
    @shopping_cart = session[:shopping_cart_id] ? ShoppingCart.find(shopping_cart_id) : ShoppingCart.create
    session[:shopping_cart_id] = @shopping_cart.id
  end
end
