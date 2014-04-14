class Clipboard < ActiveRecord::Base
  belongs_to :user
  belongs_to :software

  attr_accessible :software, :user, :text



end