class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :addresses
  has_many :orders

  def confirmed_orders
    self.orders.where(:status =>1)
  end

  def full_name
  	[first_name,middle_name,last_name].join(" ")
  	
  end

  def default_billing_address
    existed_default_billing = addresses.where(:is_default_billing => true).first
    existed_default_billing
  end

  def default_shipping_address
    existed_default_shipping = addresses.where(:is_default_shipping => true).first
    existed_default_shipping
  end

  def not_default_addresses
  	addresses.where(:is_default_shipping => false,:is_default_billing => false)
  end

end
