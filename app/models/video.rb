class Video < ActiveRecord::Base
  self.table_name = 'Movie'

  belongs_to :software

  attr_accessible :filename, :name, :timestamp, :times, :length, :software

  def log(software, user)
    last_lm = LogMovie.where(:software_id => software, :video_id => self, :user_id => user).order('started DESC').first
    length = 2.hours if length == 0
    if !last_lm || (last_lm.started.to_i - DateTime.current.to_i)/60 > length
      LogMovie.create(:software => software, :user => user, :movie => self, :started => DateTime.current)
    end

  end


end