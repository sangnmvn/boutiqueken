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

  def determine_width_menu(number_menu)
    if number_menu <= 25
      "two-col-menu"
    elsif number_menu >=48 && number_menu <75
      "three-col-menu"
    elsif number_menu >75
      "four-col-menu"
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
    if obj.friendly_id?
      obj.friendly_id
    else
      obj.id
    end
  end
end
