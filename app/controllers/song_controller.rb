class SongController < ApplicationController

  include ApplicationHelper

  def create
    @user = current_user
    if @user
      s = Software.find_by_filepath(params[:software_path])
      @song = Song.find_or_create_by_name_and_artist(:fileName => params[:fileName], :name => params[:name], :artist => params[:artist], :length => params[:length])
      @song.log(s, @user)
    end
    render json: @song
  end

end