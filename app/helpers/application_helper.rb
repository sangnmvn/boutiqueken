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
    if group_filter.downcase == "color"
      "li-color"
    elsif group_filter.downcase == "customer ratings"
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
end
