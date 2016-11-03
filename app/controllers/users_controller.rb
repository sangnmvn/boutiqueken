class UsersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout "devise"
  before_filter :get_user, :only =>[:profile,:update,:dashboard]
  before_filter :authenticate_user!
  def index
    # redirect_to new_user_session_path
  end

  def update
    user = current_user

    if user.valid_password?(params[:user][:current_password])
      if user.update_attributes(user_params)
        sign_in user, :bypass => true
        flash[:notice] = "Your Password is updated successfully!"
        redirect_to profile_user_path(current_user)
      else
        flash[:error] = user.errors.full_messages.first.html_safe
      end
    else
      flash[:error] = "Your entered Current Password is incorrect."
      redirect_to profile_user_path
    end
  end

  def profile
    	
  end

  def address_book
    @default_billing = current_user.default_billing_address
    @default_shipping = current_user.default_shipping_address
    @other_address = current_user.not_default_addresses
  end

  def get_user
    @user = User.find(params[:id])
  end

  def dashboard
    @default_billing = current_user.default_billing_address
    @default_shipping = current_user.default_shipping_address
  end

  def orders
    @orders = current_user.confirmed_orders 
  end

  protected
  def user_params
    params.require(:user).permit(:password, :password_confirmation,:first_name,:last_name)
  end

end
