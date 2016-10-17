class AddressesController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout "devise"
  before_filter :get_address,:only =>[:show,:edit,:destroy,:update]
  before_filter :authenticate_user!

  def index
  	
  end
  def new
  	@address = Address.new({:user_id => current_user.id})
  end

  def create
    @address = Address.new(address_params.merge({user_id: current_user.id}))
    if @address.save
      redirect_to address_book_user_path(current_user)
    end
  end

  def update
    puts @address.update_attributes(address_params)
    puts @address.errors.inspect
    if @address.save
      redirect_to address_book_user_path(current_user)
    end  
  end

  protected
  def get_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:first_name,:last_name,:company_name,:telephone, :fax,:street_address,:street_address2,:city,:state,:zip_code,:country,:is_default_billing,:is_default_shipping)  
  end


end