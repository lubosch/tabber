class SoftwareController < ActionController::Base
  include ApplicationHelper

  def last


    #@user = current_user
    @user = User.find(6)




    render json: @user.last_software(24.hours.ago)


  end


end