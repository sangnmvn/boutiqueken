class Address < ActiveRecord::Base
  belongs_to :user
  before_save :set_billing_shipping_default

  def full_name
    [first_name,last_name].join(" ")
  end

  def full_address
    contry = Carmen::Country.coded(self.country)
    full_state_name = contry.subregions.coded(self.state)
    [city,full_state_name,zip_code].join(" ")
  end

  def country_name
    contry = Carmen::Country.coded(self.country).name
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
