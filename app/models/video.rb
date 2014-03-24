class Video < ActiveRecord::Base
  self.table_name = 'Movie'

  belongs_to :software

  attr_accessible :filename, :name, :timestamp, :times, :length, :software

  def log(software, user)
    length = 7200 if !length || length == 0    
    last_lm = LogMovie.where('',:software_id => software, :movie_id => self, :user_id => user).where("started > ?", length.seconds.ago).first
    if !last_lm
      LogMovie.create(:software => software, :user => user, :movie => self, :started => DateTime.now)
    end

  end


end