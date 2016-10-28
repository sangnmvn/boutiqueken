class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_filter :configure_permitted_parameters , if: :devise_controller?
  before_filter :get_main_menus
  before_filter :extract_shopping_cart
  protected

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

  def after_sign_in_path_for(resource)
    profile_user_path(resource.id)
  end

   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name,:last_name,:middle_name, :is_contact_reference,:is_skas_member,
        :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name,:last_name,:middle_name, :is_contact_reference,:is_skas_member,
        :email, :password, :password_confirmation)
    end
  end

  def get_main_menus
    @main_menus = Category.main_menus
  end

  def extract_shopping_cart
    shopping_cart_id = session[:shopping_cart_id]
    @shopping_cart = session[:shopping_cart_id] ? ShoppingCart.find(shopping_cart_id) : ShoppingCart.create
    session[:shopping_cart_id] = @shopping_cart.id
  end

end
