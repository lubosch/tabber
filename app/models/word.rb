class Word < ActiveRecord::Base
  self.table_name = 'Word'

  belongs_to :user
  has_many :word_headings
  has_many :word_texts



end