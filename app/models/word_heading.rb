class WordHeading < ActiveRecord::Base
  self.table_name = 'Heading_Word'

  belongs_to :word


  def keywords
    words = self.text
    return nil if words.to_s.blank?
    self.previous_id ? level = 2 : level = 1
    return {:keywords => words, :level => level, :document => word.name, :type => "word heading"}
  end

  #
  #def context
  #  lang = CLD.detect_language(self.text)[:code]
  #  keywords = TermNormalizer.normalize(self.text, lang)
  #  return nil if keywords.count ==0
  #  keywords_stemmed = StemNormalizer.normalize(keywords.clone, lang)
  #  self.previous_id ? level = 2 : level = 1
  #  return {:keywords => keywords, :keywords_stemmed => keywords_stemmed, :level => level, :lang => lang, :type => "word heading"}
  #end

  def id_name
    "Microsoft Word"
  end

end