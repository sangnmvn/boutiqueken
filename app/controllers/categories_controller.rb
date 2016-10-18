class CategoriesController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :get_category, only: [:show]
  layout "devise"
  def show
  	@feature_categories = FeaturedCategory.where(:parent_id => @category.id,:is_top_sale =>false)
  	@top_sales_categories = FeaturedCategory.where(:parent_id => @category.id,:is_top_sale =>true)
  	@left_navs = @category.left_navs
  end

  protected
  def get_category
  	@category = Category.find(params[:id])
  end
end