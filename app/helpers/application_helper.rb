module ApplicationHelper
  def render_title
    [["Mr","Mr"],["Ms","Ms"],["Mrs","Mrs"]]
  end

  def active_address_left_menu
  	if params[:controller] == "addresses" || params[:action]=="address_book"
      return "active"
    else
      return ""
    end 
  end

  def active_order_left_menu
    if @order.present? || (params[:controller] == "users" && params[:action]=="orders")
      return "active"
    else
      return ""
    end 
  end

  def determine_type(group_filter)
    if group_filter.downcase.strip == "color"
      "li-color"
    elsif group_filter.downcase.strip == "customer ratings"
      "li-cus-review"
    end
  end

  def determine_per_page_select(per_attribute,current_per_page)
    if per_attribute == current_per_page.to_i
      "active-per"
    else
      "normal-per"
    end
    
  end

  def perpage_item_of(total_record,current_page,per_page)
    records = current_page*per_page.to_i
    if records > total_record
      total_record
    else
      records
    end
  end

  def show_image_url(url)
    if url.present?
      "http://macys-o.scene7.com/is/image/MCY/products/"+url
    else
      ""
    end
  end

  def show_small_image_url(url)
    if url.present?
      "http://macys-o.scene7.com/is/image/MCY/products/"+url +"?wid=100"
    else
      ""
    end
  end

  def show_large_image_url(url)
    if url.present?
      "http://macys-o.scene7.com/is/image/MCY/products/"+url +"?wid=1000"
    else
      ""
    end
  end

  def show_image_in_detail(url)
    if url.present?
      "http://macys-o.scene7.com/is/image/MCY/products/"+url +"?wid=400&hei=489"
    else
      ""
    end
  end

  def size_chart_id_url(size_id)
    return "http://www1.macys.com/dyn_img/size_charts/" + size_id.to_s + ".gif" if size_id.present?
  end


  def show_image_product_list(url)
    if url.present?
      "http://macys-o.scene7.com/is/image/MCY/products/"+ url + "?wid=224&qlt=90,0"
    else
      ""
    end
  end

  def show_image_product_detail(url)
    if url.present?
      "http://macys-o.scene7.com/is/image/MCY/products/"+ url + "?wid=400&hei=489"
    else
      ""
    end
  end


  def show_image_small_slider(url)
    if url.present?
      "http://macys-o.scene7.com/is/image/MCY/products/"+ url + "?wid=99&hei=146"
    else
      ""
    end
    
  end

  def show_image_cus_love(url)
    
    if url.present?
      "http://macys-o.scene7.com/is/image/MCY/products/"+ url + "?wid=126&hei=154"
    else
      ""
    end
  end


  def show_image_50_50(url)
    if url.present?
      "http://macys-o.scene7.com/is/image/MCY/products/"+ url + "?wid=60"
    else
      ""
    end
    
  end

  def determine_width_menu(menu)
     
    map = [{:name=>"HOME",:value=> "four-col-menu"},
            {:name=>"BED & BATH",:value=> "four-col-menu"},
            {:name=>"WOMEN",:value=> "four-col-menu"},
            {:name=>"MEN",:value=> "four-col-menu"},
            {:name=>"JUNIORS",:value=> "four-col-menu"},
            {:name=>"KIDS",:value=> "four-col-menu"},
            {:name=>"ACTIVE",:value=> "three-col-menu"},
            {:name=>"BEAUTY",:value=> "four-col-menu"},
            {:name=>"SHOES",:value=> "three-col-menu"},
            {:name=>"HANDBAGS",:value=> "three-col-menu"},
            {:name=>"JEWELRY",:value=> "three-col-menu"},
            {:name=>"WATCHES",:value=> "three-col-menu"},
            {:name=>"BRANDS",:value=> "four-col-menu"},
            {:name=>"GIFTS",:value=> "three-col-menu"}]

    existed_menu = map.select{|x| x[:name] == menu.cat_name}
    if existed_menu.present?
      return existed_menu.first[:value]
    else
      "three-col-menu"
    end
  end

  def determine_width_menu_long(menu)
    map = [{:name=>"HOME",:value=> 20},
            {:name=>"BED & BATH",:value=> 20},
            {:name=>"WOMEN",:value=> 28},
            {:name=>"MEN",:value=> 20},
            {:name=>"JUNIORS",:value=> 20},
            {:name=>"KIDS",:value=> 20},
            {:name=>"ACTIVE",:value=> 25},
            {:name=>"BEAUTY",:value=> 20},
            {:name=>"SHOES",:value=> 20},
            {:name=>"HANDBAGS",:value=> 20},
            {:name=>"JEWELRY",:value=> 25},
            {:name=>"WATCHES",:value=> 20},
            {:name=>"GIFTS",:value=> 30},
            {:name=>"BRANDS",:value=> 20}]

    existed_menu = map.select{|x| x[:name] == menu.cat_name}
    if existed_menu.present?
      return existed_menu.first[:value].to_i
    else
      30
    end
  end

  def determine_width_menu_class(menu)
    map = [{:name=>"HOME",:value=> "home-menu"},
            {:name=>"BED & BATH",:value=> "bed-menu"},
            {:name=>"WOMEN",:value=> "women-menu"},
            {:name=>"MEN",:value=> "men-menu"},
            {:name=>"JUNIORS",:value=> "junior-menu"},
            {:name=>"KIDS",:value=> "kids-menu"},
            {:name=>"ACTIVE",:value=> "active-menu"},
            {:name=>"BEAUTY",:value=> "beaty-menu"},
            {:name=>"SHOES",:value=> "shoes-menu"},
            {:name=>"HANDBAGS",:value=> "handbags-menu"},
            {:name=>"JEWELRY",:value=> "jewelry-menu"},
            {:name=>"WATCHES",:value=> "watches-menu"},
            {:name=>"BRANDS",:value=> "brands-menu"},
            {:name=>"GIFTS",:value=> "gifts-menu"}]

    existed_menu = map.select{|x| x[:name] == menu.cat_name}
    if existed_menu.present?
      return existed_menu.first[:value]
    end
  end

  def show_price_digit(price)
    number_with_precision(price, :precision => 2)
  end


  def determine_max_menu(menu_count)
    if menu_count < 30
      15
    elsif menu_count < 50
      20
    elsif menu_count < 70
      25
    elsif menu_count > 70
      30
    end

  end

  def f_id(obj)
    if obj.friendly_id? || obj.slug.present?
      obj.friendly_id
    else
      obj.id
    end
  end


  def show_order_status(status)
    map_k = {0=>"Init",1 =>"Confirmed"}
    return map_k[status]
  end

  def determine_static_left_selected(action,controller="home")
    if params[:controller] == controller && params[:action] == action
      return "active"
    else
      return ""
    end
  end
  
  def full_image_link(img_link)
    Rails.application.config.host_app.to_s + asset_path(img_link)
  end
end
