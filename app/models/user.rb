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

  def add_default_address(ship_params,billing_params)
    ship_params[:is_default_billing] = false
    ship_params[:is_default_shipping] = true

    billing_params[:is_default_billing] = true
    billing_params[:is_default_shipping] = false

    Address.create(ship_params.permit(:user_id,:first_name,:last_name,:company_name,:telephone, :fax,:street_address,:street_address2,:city,:state,:zip_code,:country,:is_default_billing,:is_default_shipping,:country) );
    Address.create(billing_params.permit(:user_id,:first_name,:last_name,:company_name,:telephone, :fax,:street_address,:street_address2,:city,:state,:zip_code,:country,:is_default_billing,:is_default_shipping,:country));
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
