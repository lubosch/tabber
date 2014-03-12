class LogSoftwareController < ActionController::Base
  include ApplicationHelper

  def create
    @user = User.find(params[:user_id])
    if @user 
      if !params[:process_name].to_s.blank?

      s = Software.find_or_create_by_process(:process => params[:process_name], :filepath => params[:filepath], :name => params[:description])
      ls = LogSoftware.last
      ls = LogSoftware.create(:softwareWindowName => params[:window_name], :timestamp => DateTime.now, :user => @user, :software => s) if ls.softwareWindowName != params[:window_name]
end    
render json: ls
else
    render :status => 401, :nothing => true
    end

  end

end