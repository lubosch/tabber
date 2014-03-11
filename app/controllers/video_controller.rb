class VideoController < ApplicationController
  include ApplicationHelper

  def create

    @user = current_user
    if @user

      url = URI.parse('https://gdata.youtube.com/feeds/api/videos/' + params[:video_id] + '?v=2&alt=jsonc')

      response = Net::HTTP.start(url.host, use_ssl: true) do |http|
        http.get url.request_uri, 'User-Agent' => 'MyLib v1.2'
      end

      metadata = JSON.parse response.body

      if metadata
        metadata= metadata['data']
        length = metadata['duration']
        category = metadata['category']
        title = metadata['title']
        s = Software.find_or_create_by_filepath_and_name_and_process('www.youtube.com', 'YouTube', '-1')

        if category == 'Music'
          artist, name = clear_name(title)
        end

        if artist && name
          @song = Song.find_or_create_by_name_and_artist(:fileName => params[:url], :name => name, :artist => artist, :length => length)
          last_ls = LogSong.where(:software_id => s, :song_id => @song, :user_id => @user).order('started DESC').first
          if !last_ls || (last_ls.started.to_i - DateTime.current.to_i)/60 > length
            LogSong.create(:software => s, :user => @current_user, :song => @song, :started => DateTime.current)
          end

        else
          @video = Video.find_or_create_by_name(:filename => params[:url], :name => title, :length => length, :timestamp => DateTime.current, :times => 1, :software => s)
          last_lm = LogMovie.where(:software_id => s,:video_id => @video, :user_id => @user).order('started DESC').first
          if !last_lm || (last_lm.started.to_i - DateTime.current.to_i)/60 > length
            LogMovie.create(:software => s, :user => @current_user, :movie => @video, :started => DateTime.current)
          end
        end

      end
    end

    render :status => 200, json: @video

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