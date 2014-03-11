class Software < ActiveRecord::Base

  self.table_name = 'Software'

  has_many :log_softwares

  attr_accessible :name, :process, :filepath


end