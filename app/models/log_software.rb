class LogSoftware < ActiveRecord::Base
  self.table_name = 'Log_Software'

  belongs_to :software
  belongs_to :user


  attr_accessible :softwareWindowName, :timestamp, :user, :software, :length


  scope :timestamp_within, lambda { |time_ago| {:conditions => ['[Log_software].timestamp   > ?', time_ago]} }


  def last(user)
    LogSoftware.where(:user_id => user).order('timestamp DESC').first
  end


  def keywords
    words = softwareWindowName.clone
    return nil if words.to_s.blank?
    return {:keywords => words, :type => "StartedActive", :timestamp => timestamp, :length => length}
  end

  #def context
  #  lang = CLD.detect_language(softwareWindowName)[:code]
  #  keywords = TermNormalizer.normalize(softwareWindowName.clone, lang)
  #  return nil if softwareWindowName.to_s == "" || keywords.count==0
  #  keywords_stemmed = StemNormalizer.normalize(keywords.clone, lang)
  #
  #  return {:keywords => keywords, :keywords_stemmed => keywords_stemmed, :lang => lang, :type => "activity"}
  #end

  def id_name
    software.name
  end

  def soft_id
    software.id
  end


end