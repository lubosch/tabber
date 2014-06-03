# encoding: UTF-8
class LogMovie < ActiveRecord::Base
  self.table_name = 'Log_Movie'

  belongs_to :movie, :class_name => 'Video'
  belongs_to :software
  belongs_to :user

  attr_accessible :movie, :software, :user, :started

  def keywords
    words = movie.name.scan(/[\p{L}\d]+/)
    {:keywords => words, :keywords_stemmed => [], :lang => "exact", :type => "movie"}
  end

  def id_name
    software.name
  end
  def soft_id
    software.id
  end

end