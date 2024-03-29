class Product < ActiveRecord::Base
  has_many :product_details,class_name: "ProductPriceDetail"
  
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  def slug_candidates
    [
      [:short_desc],
      [:id, :short_desc]
    ]
  end
  
  def should_generate_new_friendly_id?
    new_record? || slug.blank?
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
    string :site_cat_id
    string :site_product_id

    text :seo_title
    text :seo_keywords
    text :seo_desc

    boolean :is_child, :stored => true
    
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


    string :sizes_list,:multiple => true ,:stored => true do 
      list_sizes
    end

    dynamic_string :filters, :multiple => true,:stored=>true do
      product_atts_key_pairs.inject({}) do |hash, e|
        hash.merge(e[0].to_sym => e[1])
      end
    end
  end

  def product_atts_key_pairs
    fixed_value = product_atts.chars.inject("") do |str, char|
      unless char.ascii_only? and (char.ord < 32 or char.ord == 127)
        str << char
      end
      str
    end

    new_atts = []
    
    JSON.parse(fixed_value).to_a.each_with_index do |att, i|
      unless ["SHOW_MEMBER_IMAGE","PRODUCT_ADDITIONAL_IMAGES",
              "INTL_SIZE_CHART","PRODUCT_PORTRAIT_IMAGE",
              "PDF_EMAIL_DESCRIPTION","BULLET_TEXT",
              "FABRIC_CONTENT",
              "SHIPPING_BULLET_TEXT"].include? att[0]
        new_atts << att
      end
    end

    new_atts
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

    keyword = params_t[:search_txt].gsub(/-/i, ' ').to_s
    
  	list_product = Product.search do
  	  fulltext keyword
      group :site_product_id
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
    return list_product.group(:site_product_id).groups,list_product
  end


  def self.filter_at_category(params_t,page,per_page,filter_names)
    if params_t[:color_selected].present? &&  params_t[:color_selected].include?("Multi")
      params_t[:color_selected] = []
    end

    #search = Product.search do  dynamic("filters") do     with("SPORT").any_of(['Yoga'])  endend.results

    list_product = Product.search do
      with(:brand_names,params_t[:brand_selected]) if params_t[:brand_selected].present?
      with(:color_name,params_t[:color_selected]) if params_t[:color_selected].present?
      # with(:sizes_list,params_t[:size_selected]) if params_t[:size_selected].present?
      with(:site_cat_id,params_t[:category_id]) if params_t[:category_id].present?
      if params_t[:price_selected].present?
        min = 9999
        max = 0 
        params_t[:price_selected].each do |i|
          start,finish = i.split("|")
          min = start.to_f if min > start.to_f
          max = finish.to_f  if max < finish.to_f
          
        end
        with(:sale_price,Range.new(min,max)) if min.present? && max.present?
      end
      
      if params_t[:filter].present?
        filter_names.each do |i|
          if i.include? "SIZE"
            with(:sizes_list).any_of(params_t[:filter][i.to_sym])
          else
            if params_t[:filter][i.to_sym].present?
              dynamic("filters") do
                with(i.to_sym).any_of(params_t[:filter][i.to_sym])
              end
            end
          end
        end
      end

      order_by :sale_price, :asc
      paginate :page => page, :per_page => per_page
    end
    return list_product
  end


  def parse_size_chart_table
    return "" if self.size_chart_table.blank?
    JSON.parse(self.size_chart_table)
  end

  def list_price_range
    return "" if self.price_range.blank?
    JSON.parse(self.price_range)
  end

  def list_child_site_ids
    return [] if self.child_site_product_ids.blank?
    JSON.parse(self.child_site_product_ids)
    
  end

  def list_related_product_ids
    return [] if self.related_products.blank?
    JSON.parse(self.related_products)
    
  end

  def list_related_loved_products_ids
    
    return [] if self.related_loved_products.blank?
    JSON.parse(self.related_loved_products)
  end

  def to_friend_or_id
    if self.friendly_id? || self.slug.present?
      self.friendly_id
    else
      self.save
      self.friendly_id
    end
  end
end