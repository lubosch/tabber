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


end