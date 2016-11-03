class OrderAddress < ActiveRecord::Base
  belongs_to :order
  def full_name
    [first_name,last_name].join(" ")
  end

  def show_address
    return street_address if street_address.present?
    return street_address2
  end

  def cit_state
    return [city.to_s,state].join(", ") + zip_code.to_s
  end
end