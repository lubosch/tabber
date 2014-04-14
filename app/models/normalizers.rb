class Normalizers
  def self.stem_with_stop_words(string, lang)

    string = Normalizers::TermNormalizer.normalize string, lang
    string = Normalizers::StemNormalizer.normalize string, lang
    string
  end

end
