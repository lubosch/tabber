  class LogMovie < ActiveRecord::Base
  self.table_name = 'Log_Movie'

  belongs_to :movie, :class_name => 'Video'
  belongs_to :software
  belongs_to :user

  attr_accessible :movie, :software, :user, :started

  def context
    keywords = movie.name.scan(/[\p{L}\d]+/)
    {:keywords => keywords, :keywords_stemmed => [], :lang => "exact", :type => "movie"}
  end

  def id_name
    software.name
  end

end