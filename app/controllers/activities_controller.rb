class ActivitiesController < ApplicationController
  def show

<<<<<<< HEAD
    user = current_user
    if (params[:range])
      date = Time.parse(params[:range])
      @logs = user.last_log_software_tabber(date)
      #binding.pry
=======
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
>>>>>>> 5946e7d03528a6cd273480908316105fed7218cd
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