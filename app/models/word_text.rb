class WordText < ActiveRecord::Base
  self.table_name = 'Text_Word'

  belongs_to :word

  def keywords
    words = self.text
    return nil if words.to_s.blank?
    return {:keywords => words, :document => word.name, :type => "word text"}
  end

  #def context
  #  lang = CLD.detect_language(self.text)[:code]
  #  keywords = TermNormalizer.normalize(self.text, lang)
  #  return nil if keywords.count ==0
  #  keywords_stemmed = StemNormalizer.normalize(keywords.clone, lang)
  #  return {:keywords => keywords, :keywords_stemmed => keywords_stemmed, :lang => lang, :type => "word text"}
  #
  #end

  def id_name
    "Microsoft Word"
  end

end