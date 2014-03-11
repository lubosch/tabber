class Video < ActiveRecord::Base
  self.table_name = 'Movie'

  belongs_to :software

  attr_accessible :filename, :name, :timestamp, :times, :length, :software


end