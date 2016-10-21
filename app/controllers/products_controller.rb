class ProductsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_filter :authenticate_user!
  before_filter :get_product, only: [:show]
  layout "devise"

  def show
  	@product_related = Product.where(:site_product_id =>@product.related_products)
    @product_loved = Product.where(:site_product_id =>@product.related_loved_products)

    if @product.is_collection

      @product_childrens = Product.where(:site_product_id =>@product.child_site_product_ids)
    end
  end

  protected
  def get_product
  	@product = Product.find(params[:id])
  end
end