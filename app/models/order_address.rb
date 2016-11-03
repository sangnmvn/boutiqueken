class OrderAddress < ActiveRecord::Base
  belongs_to :order
  after_save :update_order_billing_shipping

  # validates :order, :presence => true
  def update_order_billing_shipping
    order = self.order
    if self.address_type =="shipping"
      
      order.update_attributes({:shipping_address_id => self.id})
    else
      order.update_attributes({:billing_address_id => self.id})
    end
  end

  def full_name
    [first_name,last_name].join(" ")
  end

  def show_address
    return street_address if street_address.present?
    return street_address2
  end

  def city_state
    return [city.to_s,state].join(", ") + zip_code.to_s
  end
end