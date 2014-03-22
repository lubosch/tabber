class SongController < ApplicationController

  include ApplicationHelper

  def create
    @user = User.find(params[:user_id]) if (params[:user_id])
    if @user
      s = Software.find_by_process(params[:software_name])
      @song = Song.find_or_create_by_name_and_artist(:fileName => params[:filename], :name => params[:name], :artist => params[:artist], :length => params[:length], :genre => params[:genre])
      @song.log(s, @user)
    end
    render json: @song
  end

end