class LogSoftwareController < ActionController::Base
  include ApplicationHelper

  def create
    @user= current_user

    if @user && !params[:process_name].to_s.blank?
      s = Software.find_or_create_by_process(:process => params[:process_name], :filepath => params[:filepath], :name => params[:description])
      ls = LogSoftware.last
      ls = LogSoftware.create(:softwareWindowName => params[:window_name], :timestamp => DateTime.current, :user => @user, :software => s) if ls.softwareWindowName != params[:window_name]
      render json: ls
    else
      render status: 401
    end

  end

end