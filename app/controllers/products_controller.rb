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
    @seo_title = [params[:search_txt].to_s,"Boutiqueken"].join(" | ")
    @seo_desc = "Free shipping. Free returns. All the time. Shop #{params[:search_txt].to_s}"
    @seo_keywords = ""
    @page = params[:page] || 1
    @per_page = params[:per_page] || 100
    @search,@orginal = Product.search_with_params(params,@page,@per_page)
    @results =[]
    @brands = []
    @search.each do |group|
      @results +=group.results
      #@brands +=group.facet(:brand_names).rows.map!{|col| col.value}.map{|x| [x,false]}
    end
    @products = @results
    #@product_prices = ProductPriceDetail.where(:id =>@search.facet(:product_detail_ids).rows.map!{|col| col.value})
    # @color_names = @product_prices.map{|x| [x.color_name,x.color_image,x.id,false]}
    @color_names = [["Red",false],["Silver",false],["Yellow",false],["Black",false],["Blue",false],["Brown",false],["Gold",false],["Ivory",false],["Gray",false],["Green",false],["Orange",false],["Pink",false],["White",false],["Multi",false]]
    #@brands =[]
    @brands =@orginal.facet(:brand_names).rows.map!{|col| col.value}.map{|x| [x,false]}
    # @brands = @search.results.map{|x| [x.brand_name,false]}.uniq
  end

  protected
  def get_product
  	@product = Product.find(params[:id])
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      
      if (params[:category_id].to_i == @category.id && params[:category_id].to_s.length == @category.id.to_s.length) || (params[:id].to_i == @product.id && params[:id].to_s.length == @product.id.to_s.length)
        redirect_to category_product_path({:category_id => @category.to_friend_or_id,:id =>@product.to_friend_or_id}) and return
      end

    else
      if params[:id].to_i == @product.id && params[:id].to_s.length == @product.id.to_s.length
        redirect_to product_path(@product.to_friend_or_id) and return
      end
    end
  end
end