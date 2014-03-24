class SoftwareController < ActionController::Base
  include ApplicationHelper

  def last
    @user = current_user
    if @user.nil?
      render json: @user
    else
      render json: @user.last_software(1.hours.ago)
    end


  end

  def create
    @sofware = Software.find_or_create_by_filepath(:filepath  => params[:filepath], :name => params[:name], :process => params[:process], :ignore => 0)
    render json: @sofware
  end

end