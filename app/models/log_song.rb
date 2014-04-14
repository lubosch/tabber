# encoding: UTF-8
class LogSong < ActiveRecord::Base
  self.table_name = 'Log_Song'

  belongs_to :song
  belongs_to :software
  belongs_to :user

  attr_accessible :song, :software, :user, :started

  def context

    keywords = song.name.to_s + " " + song.artist.to_s + " " + song.genre.to_s
    keywords = keywords.scan(/[\p{L}\d]+/)

    {:keywords => keywords, :keywords_stemmed => [], :lang => "exact", :type => "movie"}
  end

  def id_name
    software.name
  end

end