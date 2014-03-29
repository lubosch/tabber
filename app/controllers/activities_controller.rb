class ActivitiesController < ApplicationController
  def show

    #user = User.find(6)

    user = current_user
    if user

      if (params[:range])
        date = Time.parse(params[:range])
        @logs = user.last_log_software_tabber(date)
        #binding.pry
      else
        @logs = user.last_log_software_tabber(24.hours.ago)
      end
    else

      render 'static_pages/not_authorized'
      return

    end

    respond_to do |format|
      format.html # _show.html.erb
      format.js
    end

  end
end