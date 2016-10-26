class Product < ActiveRecord::Base
  has_many :product_details,class_name: "ProductPriceDetail"
  
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      [:id,:short_desc]
    ]
  end
  
  searchable do
    text :short_desc, :default_boost => 2
    text :long_desc
    double :regular_price
    double :sale_price
    text :brand_name
    text :sizes
    text :shipping_return
    integer :category_id
    string :color_name,:multiple => true do
      result = []
      result = product_details.pluck(:color_name)
      result & result
    end

    string :product_detail_ids,:multiple => true do
      result = []
      result = product_details.pluck(:id)
      result & result
    end

    string :brand_names,:multiple => true do 
      [brand_name]
    end


    string :sizes_list,:multiple => true do 
      sizes.to_s.split(",")
    end




  end

  def list_sizes
  	return [] if self.sizes.blank?
  	JSON.parse(self.sizes)
  	
  end

  def list_bullets
    return [] if self.bullet_text.blank?
    JSON.parse(self.bullet_text)
  end

  def self.search_with_params(params_t,page,per_page)
    range_price = []

    keyword = params_t[:search_txt].to_s
  	list_product = Product.search do
  	  fulltext keyword
      facet :product_detail_ids, limit: 20
      facet :brand_names, limit: -1,:distinct =>true
      with(:brand_names,params_t[:brand_selected]) if params_t[:brand_selected].present?
      with(:color_name,params_t[:color_selected]) if params_t[:color_selected].present?

      if params_t[:price_selected].present?
        params_t[:price_selected].each do |i|
          start,finish = i.split("|")
          puts start
          puts finish
          with(:sale_price,Range.new(start,finish)) if start.present? && finish.present?
        end
      end

      paginate :page => page, :per_page => per_page
  	end
    return list_product
  end


  def self.filter_at_category(params_t,page,per_page)
    if params_t[:color_selected].present? &&  params_t[:color_selected].include?("Multi")
      params_t[:color_selected] = []
    end

    list_product = Product.search do
      with(:brand_names,params_t[:brand_selected]) if params_t[:brand_selected].present?
      with(:color_name,params_t[:color_selected]) if params_t[:color_selected].present?
      with(:category_id,params_t[:category_id]) if params_t[:category_id].present?
      if params_t[:price_selected].present?
        params_t[:price_selected].each do |i|
          start,finish = i.split("|")
          puts start
          puts finish
          with(:sale_price,Range.new(start,finish)) if start.present? && finish.present?
        end
      end
      order_by :sale_price, :asc
      paginate :page => page, :per_page => per_page
    end
    return list_product
  end
end