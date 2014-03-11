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
    @sofware = Software.find_or_create_by_filepath(params[:filepath], params[:name], params[:process])
    render json: @sofware
  end

end