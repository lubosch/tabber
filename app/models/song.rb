class Song < ActiveRecord::Base
  self.table_name = 'Song'

  has_many :log_songs

  attr_accessible :fileName, :name, :artist, :genre, :length


  def log(software, user)
    length = 600 if !length || length == 0
    last_ls = LogSong.where(:software_id => software, :song_id => self, :user_id => user).where("started > ?", length.seconds.ago).first
    if !last_ls
      LogSong.create(:software => software, :user => user, :song => self, :started => DateTime.now)
    end

  end


end