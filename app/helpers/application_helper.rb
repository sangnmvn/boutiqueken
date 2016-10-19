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
end
