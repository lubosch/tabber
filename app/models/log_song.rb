# encoding: UTF-8
class LogSong < ActiveRecord::Base
  self.table_name = 'Log_Song'

  belongs_to :song
  belongs_to :software
  belongs_to :user

  attr_accessible :song, :software, :user, :started

  def keywords

    words = song.name.to_s + " " + song.artist.to_s + " " + song.genre.to_s
    words = words.scan(/[\p{L}\d]+/)

    {:keywords => words, :keywords_stemmed => [], :lang => "exact", :type => "song"}
  end

  def id_name
    software.name
  end

  def soft_id
    software.id
  end

end