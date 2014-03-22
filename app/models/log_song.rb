class LogSong < ActiveRecord::Base
  self.table_name = 'Log_Song'

  belongs_to :song
  belongs_to :software
  belongs_to :user

  attr_accessible :song, :software, :user, :started





end