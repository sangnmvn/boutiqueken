class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def index
    # redirect_to new_user_session_path
  end

  def subregions
  	render partial: "addresses/state_select"
  end
  
end
