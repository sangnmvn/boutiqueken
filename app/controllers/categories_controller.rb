class CategoriesController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_filter :authenticate_user!
  before_filter :get_category, only: [:show]

  layout "devise"
  def show
    @page = params[:page] || 1
    @per_page = params[:per_page] || 100
  	@feature_categories = FeaturedCategory.where(:parent_id => @category.id,:is_top_sale =>false)
  	@top_sales_categories = FeaturedCategory.where(:parent_id => @category.id,:is_top_sale =>true)
  	@left_navs = @category.left_navs
    #@products = Product.where(:site_cat_id => @category.site_cat_id).page(@page).per(@per_page)
    @filters = Filter.where(:category_id => @category.id).order("group_pos asc, sub_group_pos asc")
    @product_ls = Product.includes(:product_details).where(:site_cat_id => @category.site_cat_id).order("sale_price asc").page(@page).per(@per_page)
    #list filter_name
    @filter_names = @filters.pluck(:filter_product_field_name).uniq
    if request.xhr?
      params[:category_id] = @category.site_cat_id
      @search = Product.filter_at_category(params,@page,@per_page,@filter_names)
      @product_ls = @search.results
    end



  end

  protected
  def get_category
    @category = Category.find(params[:id])
    if params[:id].to_i == @category.id && params[:id].to_s.length == @category.id.to_s.length
      redirect_to category_path(@category.to_friend_or_id) and return
    end
  	#@category = Category.find(params[:id])
    
  end
end