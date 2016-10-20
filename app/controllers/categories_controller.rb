class CategoriesController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :get_category, only: [:show]
  layout "devise"
  def show
    page = params[:page] || 1
    @per_page = params[:per_page] || 60
  	@feature_categories = FeaturedCategory.where(:parent_id => @category.id,:is_top_sale =>false)
  	@top_sales_categories = FeaturedCategory.where(:parent_id => @category.id,:is_top_sale =>true)
  	@left_navs = @category.left_navs
    @products = Product.where(:category_id => @category.id).page(page).per(@per_page)
    @filters = Filter.where(:category_id => @category.id).order("group_pos asc")
    @product_ls = Product.where(:category_id => @category.id).page(page).per(@per_page)
  
    if request.xhr?
      @product_ls = Product.where(:category_id => @category.id).page(page).per(@per_page)
    end

  end

  protected
  def get_category
  	@category = Category.find(params[:id])
  end
end