class UserController < ActionController::Base

  def update_ip
    @user = User.find_by_pc_uniq(params[:uniq_pc])
    if params[:uniq_pc] && @user
      @user.ip = request.remote_ip
      @user.save
    end

    render json: @user

  end

end