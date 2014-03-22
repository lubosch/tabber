class LogMovie < ActiveRecord::Base
  self.table_name = 'Log_Movie'

  belongs_to :movie, :class_name => 'Video'
  belongs_to :software
  belongs_to :user

  attr_accessible :movie, :software, :user, :started



end