class Address < ActiveRecord::Base
  belongs_to :user
  before_save :set_billing_shipping_default
  def full_name
    [first_name,last_name].join(" ")
  end

  def full_address
    if self.country.present?
      contry = Carmen::Country.coded(self.country)
    else 
      contry = Carmen::Country.coded("US")
    end
    full_state_name = contry.subregions.coded(self.state.to_s) rescue self.state.to_s
    [city,full_state_name,zip_code].join(" ")
  end

  def country_name
    if self.country.present?
      contry = Carmen::Country.coded(self.country)
    else 
      contry = Carmen::Country.coded("US")
    end
  end
  
  def set_billing_shipping_default
  	
    if self.new_record?
      existed_default_billing = Address.where(:user_id => self.user_id,:is_default_billing => true)
    else
      existed_default_billing = Address.where(:user_id => self.user_id,:is_default_billing => true).where.not(:id => self.id)
    end

  	if self.is_default_billing == true
  		existed_default_billing.update_all({:is_default_billing =>false}) if existed_default_billing.present?
  	end

    

    if self.new_record?
      existed_default_shipping = Address.where(:user_id => self.user_id,:is_default_shipping => true)
    else
      existed_default_shipping = Address.where(:user_id => self.user_id,:is_default_shipping => true).where.not(:id => self.id)
    end
    
    if self.is_default_shipping == true
      existed_default_shipping.update_all({:is_default_shipping =>false}) if existed_default_shipping.present?
    end


  end

end
