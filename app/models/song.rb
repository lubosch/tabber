class Song < ActiveRecord::Base
  self.table_name = 'Song'

  attr_accessible :fileName, :name, :artist, :genre, :length



end