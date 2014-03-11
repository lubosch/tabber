class Song < ActiveRecord::Base
  self.table_name = 'Song'



  attr_accessible :fileName, :name, :artist, :genre, :length


  def log(software, user)
    last_ls = LogSong.where(:software_id => software, :song_id => self, :user_id => user).order('started DESC').first
    if !last_ls || (last_ls.started.to_i - DateTime.current.to_i)/60 > length
      LogSong.create(:software => software, :user => user, :song => self, :started => DateTime.current)
    end

  end


end