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
    @is_mobile = browser.device.mobile?
  end

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get? 
    if (request.path != "/secure-user-sign-in-up" &&
        request.path != "/secure-sign-up" &&
        request.path != "/secure-password/new" &&
        request.path != "/secure-password/new" &&
        request.path != "/confirmation" &&
        request.path != "/sign_out" &&
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
    params[:id] ||= current_user.id if current_user
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
          "/cat/16373-sunglasses" => "Sunglasses",
          "/cat/16481-levi-s" => "Levi's",
          "/cat/16526-ideology" => "Ideology",
          "/cat/16581-luxe-gifts" => "Luxe Gifts",
          "/cat/16593-limited-time-specials" => "Limited Time Specials",
          "/cat/16595-limited-time-specials" => "special",
          "/cat/16597-limited-time-specials" => "Special",
          "/cat/16599-limited-time-specials" => "Special",
          "/cat/16600-25-off-under-armour" => "Under Armour",
          "/cat/16601-limited-time-specials" => "Limited-Time Specials",
          "/cat/16603-limited-time-specials" => "Special",
          "/cat/16605-limited-time-specials" => "Special",
          "/cat/16607-limited-time-specials" => "Special",
          "/cat/16609-limited-time-specials" => "Special",
          "/cat/16611-limited-time-specials" => "Special",
          "/cat/25-40-off-clearance" => "Clearance",
          "/cat/25-60-off-clearance" => "Clearance",
          "/cat/25-off-clearance" => "Clearance",
          "/cat/25-off-under-armour" => "Under Armour",
          "/cat/40-65-off-clearance" => "Clearance",
          "/cat/40-70-off-clearance" => "Clearance",
          "/cat/45-65-off-clearance" => "Clearance",
          "/cat/55-75-off-clearance" => "Clearance",
          "/cat/all-occasions" => "Occasions",
          "/cat/athletic-shoes" => "Athletic Shoes",
          "/cat/beauty-15710-chanel" => "chanel",
          "/cat/beauty-chanel" => "chanel",
          "/cat/bed-bath-access-your-registry" => "Access Your Registry",
          "/cat/bed-bath-find-a-couple-s-registry" => "Find A Couple Registry",
          "/cat/bed-bath-winter-bedding" => "Winter Bedding",
          "/cat/brands-15949-nike" => "nike",
          "/cat/brands-15952-the-north-face" => "the north face",
          "/cat/brands-adidas" => "adidas",
          "/cat/brands-champion" => "champion",
          "/cat/brands-chanel" => "chanel",
          "/cat/brands-finish-line-athletic-shoes" => "finish line athletic shoes",
          "/cat/brands-fitbit" => "fitbit",
          "/cat/brands-ideology" => "ideology",
          "/cat/brands-puma" => "puma",
          "/cat/brands-sperry-top-sider" => "sperry",
          "/cat/brands-sports-fan-shop-by-lids" => "sports fan shop by lids",
          "/cat/brands-under-armour" => "under armour",
          "/cat/coffee-buying-guide" => "Coffee",
          "/cat/dkny-lenox" => "DKNY Lenox",
          "/cat/else-jeans" => "Else Jeans",
          "/cat/extra-25-off-clearance" => "Clearance",
          "/cat/furniture-glossary" => "Furniture Glossary",
          "/cat/gifts-e-gifting" => "gifting",
          "/cat/gifts-gifts-from-ralph-lauren" => "Gifts Ralph Lauren",
          "/cat/handbags-lenscrafters" => "LensCrafters",
          "/cat/handbags-trolls" => "handbag troll",
          "/cat/holiday-gift-sets" => "Holiday Set",
          "/cat/home-access-your-registry" => "Access Your Registry",
          "/cat/home-culinary-council" => "Culinary Council",
          "/cat/home-find-a-couple-s-registry" => "Find A Couple Registry",
          "/cat/jewelry-15830-wedding-engagement-rings" => "wedding engagement ring",
          "/cat/jewelry-anne-klein" => "Anne Klein",
          "/cat/jewelry-charter-club" => "Charter Club",
          "/cat/jewelry-givenchy" => "Givenchy",
          "/cat/jewelry-gucci" => "Gucci",
          "/cat/jewelry-lauren-ralph-lauren" => "lauren ralph lauren",
          "/cat/jewelry-lucky-brand" => "Lucky",
          "/cat/jewelry-pearls" => "Pearls",
          "/cat/jewelry-rose-gold-jewelry" => "Rose Gold Jewelry",
          "/cat/jewelry-style-your-ring" => "jewelry ring",
          "/cat/jewelry-wedding-engagement-rings" => "Wedding Engagement Rings",
          "/cat/jewelry-wrapped-in-love" => "Wrapped in Love",
          "/cat/juniors-holiday-trend-report" => "holiday junior",
          "/cat/juniors-wide-leg-pants" => "Wide-Leg Pants",
          "/cat/kids-dresses-dresswear" => "Dresses Dresswear",
          "/cat/limited-time-specials" => "Special",
          "/cat/mattresses" => "Mattresses",
          "/cat/men-designer-shoes" => "Designer Shoes",
          "/cat/men-fall-2016-holiday-trends" => "men Holiday",
          "/cat/men-s" => "Men",
          "/cat/shoes-all-kids-shoes" => "Kid Shoes",
          "/cat/shoes-boys-shoes" => "Boy Shoes",
          "/cat/shoes-fall-boot-styles" => " boot",
          "/cat/shoes-girls-shoes" => "Girl Shoes",
          "/cat/sunglasses" => "Sunglasses",
          "/cat/the-wedding-shop" => "Wedding",
          "/cat/trends-inspiration" => "Inspiration",
          "/cat/tuxedo-rental-shop" => "Tuxedo",
          "/cat/ugg" => "UGG",
          "/cat/view-all-trends" => "Trend",
          "/cat/watches-apple-watch-guide" => "Apple Watch",
          "/cat/watches-michael-kors-access" => "Michael Kors Access",
          "/cat/watches-samsung" => "Samsung",
          "/cat/watches-smart-watch-video-hub" => "Smart Watch",
          "/cat/watches-watch-trend-guide" => "Watch",
          "/cat/women-cold-weather-style" => "cold weather women",
          "/cat/women-dress-codes" => "women dress",
          "/cat/women-holiday-style-guide" => "holiday woman",
          "/cat/women-the-coat-chronicles" => "women coat"
    }

    if h[request.fullpath].present?
      url = "#{request.protocol}#{request.host_with_port}/pro/search?search_txt=#{h[request.fullpath]}"
      redirect_to URI::encode(url)
    end
  end
  
  def save_current_order
    session[:last_oid] = @order.id if @order
  end
end
