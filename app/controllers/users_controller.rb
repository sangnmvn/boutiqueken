class UsersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout "devise"
  before_filter :get_user, :only =>[:profile,:update]
  def index
    # redirect_to new_user_session_path
  end

  def profile
    	
  end

end
