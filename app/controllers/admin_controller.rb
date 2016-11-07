class AdminController < ApplicationController
  layout "admin"
  
  def index
  end

  def scrapper
    @has_in_progress_worker = true if ProcessingTask.where(status: "in-progress").count > 0

    task = ProcessingTask.where(status: "in-progress").first

    @is_paused = true if task.present? && task.action_code == "pause"

    @progress = task.progress if task.present?
  end
  
  def delete_user
    # user_id = params[:user_id]

    # User.destroy(user_id)

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

  def get_scrapping_status

  end

  def user_mgmt
    @users = User.get_users();
  end

  def create_user

  end

  def save_user
    user = User.new(:email => params[:email], :password => params[:password], :password_confirmation => params[:confirm])
    user.first_name   = params[:first_name]
    user.middle_name  = params[:middle_name]
    user.last_name    = params[:last_name]
    user.save

    render json: ""
  end
end
