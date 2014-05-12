class LogSoftwareController < ApplicationController
  include ApplicationHelper

  def create
    @user = User.find(params[:user_id])
    if @user
      @user.update_ip(request.remote_ip)
      if !params[:process_name].to_s.blank?
        s = Software.find_or_create_by_process(:process => params[:process_name], :filepath => params[:filepath], :name => params[:description], :ignore => 0)
        ls = @user.last_log
        if !ls || ls.softwareWindowName != params[:window_name]
          LogSoftware.transaction do
            if ls
              ls.length = DateTime.now.to_i - ls.timestamp.to_i
              ls.save
            end
            ls = LogSoftware.create(:softwareWindowName => params[:window_name], :timestamp => DateTime.now, :user => @user, :software => s) if !ls || ls.softwareWindowName != params[:window_name]
          end
        end
      end
      render json: ls
    else
      render :status => 401, :nothing => true
    end

  end


  def show
    ls = LogSoftware.find(params[:id])
    if ls
      render json: ls.software
    else
      render :status => 404, :nothing => true
    end

  end

  def index
    if params[:ids]
      #ls = LogSoftware.find(params[:ids]).includes(:software)
      ls = LogSoftware.where("[Log_Software].ID IN (?)", params[:ids]).includes(:software)
      res = {}
      ls.each { |q| res[q.id] = q.software.name }
      render json: res
    else
      render :status => 404, :nothing => true
    end

  end


end