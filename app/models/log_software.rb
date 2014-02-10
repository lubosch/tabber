class LogSoftware < ActiveRecord::Base
  self.table_name = 'Log_Software'

  belongs_to :software
  belongs_to :user


  attr_accessible :softwareWindowName, :timestamp


  scope :timestamp_within, lambda { |time_ago| {:conditions => ['[Log_software].timestamp   > ?', time_ago]} }



end