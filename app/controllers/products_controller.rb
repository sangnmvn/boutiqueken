class ProductsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_filter :authenticate_user!
  before_filter :get_product, only: [:show]
  layout "devise"

  def show
  	# @product_related = Product.where(:site_product_id =>@product.list_related_product_ids).group(:site_product_id,:id)
   #  @product_loved = Product.where(:site_product_id =>@product.list_related_loved_products_ids).group(:site_product_id,:id)
   @product_related = Product.select("distinct on (site_product_id) *").where(:site_product_id => @product.list_related_product_ids)
   @product_loved = Product.select("distinct on (site_product_id) *").where(:site_product_id => @product.list_related_loved_products_ids)
    if @product.is_collection

      @product_childrens = Product.select("distinct on (site_product_id) *").where(:site_product_id =>@product.list_child_site_ids)
    end
  end

  def search
    @page = params[:page] || 1
    @per_page = params[:per_page] || 100
    @search = Product.search_with_params(params,@page,@per_page)
    @products = @search.results
    @product_prices = ProductPriceDetail.where(:id =>@search.facet(:product_detail_ids).rows.map!{|col| col.value})
    # @color_names = @product_prices.map{|x| [x.color_name,x.color_image,x.id,false]}
    @color_names = [["Red",false],["Silver",false],["Yellow",false],["Black",false],["Blue",false],["Brown",false],["Gold",false],["Ivory",false],["Gray",false],["Green",false],["Orange",false],["Pink",false],["White",false],["Multi",false]]
    @brands =@search.facet(:brand_names).rows.map!{|col| col.value}.map{|x| [x,false]}
    # @brands = @search.results.map{|x| [x.brand_name,false]}.uniq
  end

  protected
  def get_product
  	@product = Product.find(params[:id])
  end
end