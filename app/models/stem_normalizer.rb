# Stem every word
class StemNormalizer

  def self.normalize(string)
    words = string.split(/\s/)
    words.map! { |w|
      w.stem
    }
    words.join(" ")
  end


  def self.normalize(words, lang)
    #words = string.downcase.scan(/\p{L}+/).join(' ')

    if ["sk", "pl", "cz"].include? lang
      words = words.join(' ') if words.class == Array
      words.gsub! /[,\.\\|\/:\s]+/, ' '
      resp= slovak_stem(words).parsed_response
      words= resp.force_encoding("windows-1250").force_encoding("utf-8").split

    elsif lang != "exact"
      words = words.downcase.split(/[,\.\\|\/:\s]+/) if words.class == String
      words.map! { |w| w.stem.encode("UTF-8", "binary", :invalid => :replace, :undef => :replace, :replace => '') }

    end

    words
  end

  def self.slovak_stem(text)
    url = "http://text.fiit.stuba.sk:8080/lematizer/services/lemmatizer/lemmatize/fast"
    HTTParty.post(url, :query => {:tools => "all", :disam => true}, :headers => {"Content-Type" => "text/plain"}, :body => text)


  end


end