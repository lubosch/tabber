class LogSoftware < ActiveRecord::Base
  self.table_name = 'Log_Software'

  belongs_to :software
  belongs_to :user


  attr_accessible :softwareWindowName, :timestamp, :user, :software


  scope :timestamp_within, lambda { |time_ago| {:conditions => ['[Log_software].timestamp   > ?', time_ago]} }


  def last(user)
    LogSoftware.where(:user_id => user).order('timestamp DESC').first
  end




end