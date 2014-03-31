class ActivitiesController < ApplicationController
  def show
    user = User.find_by_annota_id(params[:annota_id]) if params[:annota_id]
    #user = User.find(6)

    #user = current_user
    if user

      if params[:range]
        date = Time.parse(params[:range])
        @logs = user.last_log_software_tabber(date)
        #binding.pry
      else
        @logs = user.last_log_software_tabber(24.hours.ago)
      end
    else

      respond_to do |format|
        format.html {redirect_to 'http://annota-test.fiit.stuba.sk/best_pages/activities'}

        format.json do
          if user.nil?
            render json: {:status => :error, :message => 'You must be logged in to do that!'}, :status => 401
          else
            render json: {:status => :error, :message => "You don't have permission to #{exception.action} #{exception.subject.class.to_s.pluralize}"}, :status => 403
          end
        end
      end

      return

    end

    respond_to do |format|
      format.html {redirect_to 'http://annota-test.fiit.stuba.sk/best_pages/activities'}
      format.json {render json: @logs}
    end

  end
end