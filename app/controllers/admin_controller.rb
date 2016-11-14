class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_logged?
  layout "admin"

  def index
    @users_got_register = User.where(is_admin: false).count
  end
  
  def login
    if (session[:admin_id] ||= cookies.signed[:admin_id])
      flash[:msg] = {status: "success", message: "<center>You are already logged in.</center>"}
      redirect_to action: :index
      return
    end
    render :layout => false
  end
  
  def logout
    cookies.delete(:admin_id)
    session.delete(:admin_id)
    redirect_to action: :login
  end
  
  def signin
    user = User.find_by(email: params[:session][:email].downcase, is_admin: true)
    if user && user.valid_password?(params[:session][:password])
      session[:admin_id] = user.id
      cookies.signed[:admin_id] = { value: user.id, expires: 12.hour.from_now } if params[:login_page_stay_signed]
      flash[:msg] = {status: "success", message: "<center>Logged in successfully.</center>"}
      redirect_to action: :index
      return
    end
    flash[:msg] = {status: "danger", message: "<center>Login failed.</center>"}
    redirect_to action: :login
  end

  def scrapper
    @has_in_progress_worker = true if ProcessingTask.where(status: "in-progress").count > 0

    task = ProcessingTask.where(status: "in-progress").first

    @is_paused = true if task.present? && task.action_code == "pause"

    @progress = task.progress if task.present?
  end
  
  def my_profile
    @user = User.find(current_user.id)
  end
  
  def delete_user
    user_id = params[:user_id]

    User.destroy(user_id)

    render  json: "ok"
  end
    
  def interact_with_scrapper
    pause = params[:pause]
    run = params[:run]
    stop = params[:stop]

    action = run || pause || stop

    ::ScrapperWorker.interact_with_scrapper(action)

    redirect_to :action => 'scrapper'
  end

  def user_mgmt
    @current_page = [1,params[:page].to_i].max
    @per_page = 20
    @users = User.where(is_admin: false).order('updated_at DESC').page(@current_page).per(@per_page)
  end

  def order_mgmt
    @current_page = [1,params[:page].to_i].max
    @per_page = 20
    @orders = Order.where("status >= 1").order('updated_at DESC').page(@current_page).per(@per_page)
  end

  def show_order
    @order = Order.find(params[:order_id])
  end

  def change_status
    @success = false;
    @order = Order.find(params[:order_id])
    if params[:order][:status].present?
      if params[:order][:status].to_i < 4
        @order.status = params[:order][:status]
        @order.save
        @success = true
      else
        if params[:order][:tracking].present? && params[:order][:comments].present? && params[:order][:arrived_date].present?
          OrderComment.create({:order_id => @order.id, :track_status =>params[:order][:tracking], :comment =>params[:order][:comments],:user_id => current_user,:expected_arrived =>params[:order][:arrived_date]})
          @order.status = params[:order][:status]
          @order.save
          @success = true
        end
      end
    redirect_to order_mgmt_admin_index_path,:notice =>"The Order Status has been updated successfully. "
    end
  end

  def create_user

  end
  
  def edit_user
    @user = User.find(params[:user_id])
    
    
  end

  def save_user
    if params[:page] == "edit_user"
      user = User.find(params[:user_id])
      if params[:password] != params[:password_confirmation]
        flash[:msg] = {status: "danger", message: "<center>Password and Confirm Password are not the same.</center>"}
        redirect_to action: :edit_user, user_id: params[:user_id]
        return
      else
        user.password = params[:password]
      end
      flash[:msg] = {status: "success", message: "<center>User's info has been updated successfully.</center>"}
    else
      user = User.new(:email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
      user.created_at = Time.now
      flash[:msg] = {status: "success", message: "<center>User has been created successfully.</center>"}
    end
    user.first_name   = params[:first_name]
    user.middle_name  = params[:middle_name]
    user.last_name    = params[:last_name]
    user.updated_at   = Time.now
    user.save
    
    if(user.errors.full_messages.blank?)
      redirect_to action: :user_mgmt
    else
      flash[:msg] = {status: "danger", message: "<center>#{user.errors.full_messages.first}</center>"}
      redirect_to action: params[:page]
    end
  end
end
