require "open-uri"

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_filter :configure_permitted_parameters , if: :devise_controller?
  before_filter :get_main_menus
  before_filter :extract_shopping_cart
  before_filter :store_current_location, :unless => :devise_controller?
  after_filter :store_location
  before_filter :get_browser_location
  before_filter :redirect_special_link

  protected


  def get_browser_location
    #country_code
    @country_code = session[:country_code].present? ? session[:country_code] : request.location.country_code
    session[:country_code] = @country_code

    

    #@country_code = request.location.country_code
    if @country_code == "RD" || @country_code.blank?
      @country_code = "US" 
    end
    @country = Carmen::Country.coded(@country_code)
    @currency = session[:currency].present? ? session[:currency] : @country.currency_code
    session[:currency] = @currency.upcase
    @rate_exchange =  MoneyExchange.get_rate("USD",@currency)
  end

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get? 
    if (request.path != "/secure-user-sign-in-up" &&
        request.path != "/secure-sign-up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    if (resource && resource.is_admin)
      session[:previous_url] = "/admin/index"
    else
      session[:previous_url] || profile_user_path(resource.id)
    end
  end
  
  def store_current_location
    store_location_for(:user, request.url)
  end

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

  # def after_sign_in_path_for(resource)
  #   puts "==SIGNIN==="
  #   puts request.referrer
  #   request.referrer || profile_user_path(resource.id)
  # end

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
    @shopping_cart = session[:shopping_cart_id] ? (ShoppingCart.find(shopping_cart_id) rescue ShoppingCart.create)  : ShoppingCart.create
    session[:shopping_cart_id] = @shopping_cart.id
  end
  
  def admin_logged?
    if !(current_user && current_user.is_admin==true)
      redirect_to root_path
    end
  end

  def redirect_special_link
    # fullpath -> search key words
    h = {
      "/cat/beauty-chanel" => "chanel",
      "/cat/jewelry-15830-wedding-engagement-rings" => "wedding engagement ring",
      "/cat/women-cold-weather-style" => "cold weather style women",
      "/cat/women-dress-codes" => "women dress  NOUVEAU ROMANCE,  COZY CHIC , CAREER DRIVEN  , BEST-DRESSED GUEST,  LIFE OF THE PARTY, VIVA LA VELVET",
      "/cat/jewelry-style-your-ring" => "jewelry ring",
      "/cat/women-the-coat-chronicles" => "women coat PEACOAT WRAP, WOOL & BLEND, FUR & FAUX, PACKABLE, PARKA",
      "/cat/jewelry-15830-wedding-engagement-rings" => "wedding engagement ring",
      "/cat/shoes-fall-boot-styles" => " booties, over the knee boots, cold weather and rain boots, tall boots",
      "/cat/brands-chanel" => "chanel",
      "/cat/juniors-holiday-trend-report" => "holiday",
      "/cat/beauty-15710-chanel" => "chanel",
      "/cat/handbags-trolls" => "handbag troll",
      "/cat/women-holiday-style-guide" => "Merry red, sparkle and shine, va va velvet, romantic evening, bomber jacket"
    }

    if h[request.fullpath].present?
      url = "#{request.protocol}#{request.host_with_port}/pro/search?search_txt=#{h[request.fullpath]}"
      redirect_to URI::encode(url)
    end
  end
end
