require 'net/http'

class VideoController < ApplicationController
  include ApplicationHelper

  def parse_youtube

    @user = current_user
    if @user

      url = URI.parse('https://gdata.youtube.com/feeds/api/videos/' + params[:video_id] + '?v=2&alt=jsonc')

      response = Net::HTTP.start(url.host, use_ssl: false) do |http|
        http.get url.request_uri, 'User-Agent' => 'MyLib v1.2'
      end

      metadata = JSON.parse response.body

      if metadata
        metadata= metadata['data']
        length = metadata['duration']
        category = metadata['category']
        title = metadata['title']
        s = Software.find_or_create_by_filepath_and_name_and_process('www.youtube.com', 'youtube.com', '-1')

        if category == 'Music'
          artist, name = clear_name(title)
        end

        if artist && name
          @song = Song.find_or_create_by_name_and_artist(:fileName => params[:url], :name => name, :artist => artist, :length => length)
          @song.log(s, @user)
        else
          @video = Video.find_or_create_by_name(:filename => params[:url], :name => title, :length => length, :timestamp => DateTime.now, :times => 1, :software => s)
          @video.log(s, @user)
        end

      end
    end

    render :status => 200, json: @video

  end

  def create
    @user = User.find(params[:user_id])
    if @user
      s = Software.find_by_process(params[:software_name])
      @video = Video.find_or_create_by_name(:filename => params[:filename], :name => params[:name], :length => params[:length], :timestamp => DateTime.now, :times => 1, :software => s)
      @video.log(s, @user)
    end
    render json: @video
  end

  def clear_name(title)
    title.gsub!(/(\[.*?\])|(\(.*?\))/, '')

    if /-/.match(title)
      artist =/^.+-/.match(title)[0][0..-3].strip.split.map(&:capitalize)*' '
      name = title.split('-')[-1].strip.split.map(&:capitalize)*' '

    end

    return artist, name
  end
end