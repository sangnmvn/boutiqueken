class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  layout "static_layout",only: [:about_us]
  protect_from_forgery with: :exception
  def index
    # redirect_to new_user_session_path
  end

  def subregions
  	render partial: "addresses/state_select"
  end
  
  def about_us
  	
  end


  def faq
  	
  end

  def domestic_shipping_return
  	
  end

  def international_shipping_return
  	
  end

  def privacy_policy
  	
  end

  def safe_shopping_guarantee
  	
  end

  def secure_shopping
  	
  end

  def term_of_use
  	
  end

end
