# encoding: UTF-8
# Used by Annota model for normalization of keywords, tag names, folder names, person names to terms
class TermNormalizer

  # translate stop-word term names
  STOPWORDS = {
      "root" => nil # root folder name
  }

  SLOVAKSTOPWORDS = ["a", "aby", "aj", "ak", "ako", "ale", "alebo", "and", "ani", "áno", "asi", "až", "bez", "bude", "budem", "budeš", "budeme", "budete", "budú", "by", "bol", "bola", "boli", "bolo", "byť", "cez", "čo", "či", "ďalší", "ďalšia", "ďalšie", "dnes", "do", "ho", "ešte", "for", "i", "ja", "je", "jeho", "jej", "ich", "iba", "iné", "iný", "som", "si", "sme", "sú", "k", "kam", "každý", "každá", "každé", "každí", "kde", "keď", "kto", "ktorá", "ktoré", "ktorou", "ktorý", "ktorí", "ku", "lebo", "len", "ma", "mať", "má", "máte", "medzi", "mi", "mna", "mne", "mnou", "musieť", "môcť", "môj", "môže", "my", "na", "nad", "nám", "náš", "naši", "nie", "nech", "než", "nič", "niektorý", "nové", "nový", "nová", "nové", "noví", "o", "od", "odo", "of", "on", "ona", "ono", "oni", "ony", "po", "pod", "podľa", "pokiaľ", "potom", "práve", "pre", "prečo", "preto", "pretože", "prvý", "prvá", "prvé", "prví", "pred", "predo", "pri", "pýta", "s", "sa", "so", "si", "svoje", "svoj", "svojich", "svojím", "svojími", "ta", "tak", "takže", "táto", "teda", "te", "tě", "ten", "tento", "the", "tieto", "tým", "týmto", "tiež", "to", "toto", "toho", "tohoto", "tom", "tomto", "tomuto", "toto", "tu", "tú", "túto", "tvoj", "ty", "tvojími", "už", "v", "vám", "váš", "vaše", "vo", "viac", "však", "všetok", "vy", "z", "za", "zo", "že"]
  ENGLISHSTOPWORDS = ["a", "a's", "able", "about", "above", "according", "accordingly", "across", "actually", "after", "afterwards", "again", "against", "ain't", "all", "allow", "allows", "almost", "alone", "along", "already", "also", "although", "always", "am", "among", "amongst", "an", "and", "another", "any", "anybody", "anyhow", "anyone", "anything", "anyway", "anyways", "anywhere", "apart", "appear", "appreciate", "appropriate", "are", "aren't", "around", "as", "aside", "ask", "asking", "associated", "at", "available", "away", "awfully", "b", "be", "became", "because", "become", "becomes", "becoming", "been", "before", "beforehand", "behind", "being", "believe", "below", "beside", "besides", "best", "better", "between", "beyond", "both", "brief", "but", "by", "c", "c'mon", "c's", "came", "can", "can't", "cannot", "cant", "cause", "causes", "certain", "certainly", "changes", "clearly", "co", "com", "come", "comes", "concerning", "consequently", "consider", "considering", "contain", "containing", "contains", "corresponding", "could", "couldn't", "course", "currently", "d", "definitely", "described", "despite", "did", "didn't", "different", "do", "does", "doesn't", "doing", "don't", "done", "down", "downwards", "during", "e", "each", "edu", "eg", "eight", "either", "else", "elsewhere", "enough", "entirely", "especially", "et", "etc", "even", "ever", "every", "everybody", "everyone", "everything", "everywhere", "ex", "exactly", "example", "except", "f", "far", "few", "fifth", "first", "five", "followed", "following", "follows", "for", "former", "formerly", "forth", "four", "from", "further", "furthermore", "g", "get", "gets", "getting", "given", "gives", "go", "goes", "going", "gone", "got", "gotten", "greetings", "h", "had", "hadn't", "happens", "hardly", "has", "hasn't", "have", "haven't", "having", "he", "he's", "hello", "help", "hence", "her", "here", "here's", "hereafter", "hereby", "herein", "hereupon", "hers", "herself", "hi", "him", "himself", "his", "hither", "hopefully", "how", "howbeit", "however", "i", "i'd", "i'll", "i'm", "i've", "ie", "if", "ignored", "immediate", "in", "inasmuch", "inc", "indeed", "indicate", "indicated", "indicates", "inner", "insofar", "instead", "into", "inward", "is", "isn't", "it", "it'd", "it'll", "it's", "its", "itself", "j", "just", "k", "keep", "keeps", "kept", "know", "knows", "known", "l", "last", "lately", "later", "latter", "latterly", "least", "less", "lest", "let", "let's", "like", "liked", "likely", "little", "look", "looking", "looks", "ltd", "m", "mainly", "many", "may", "maybe", "me", "mean", "meanwhile", "merely", "might", "more", "moreover", "most", "mostly", "much", "must", "my", "myself", "n", "name", "namely", "nd", "near", "nearly", "necessary", "need", "needs", "neither", "never", "nevertheless", "new", "next", "nine", "no", "nobody", "non", "none", "noone", "nor", "normally", "not", "nothing", "novel", "now", "nowhere", "o", "obviously", "of", "off", "often", "oh", "ok", "okay", "old", "on", "once", "one", "ones", "only", "onto", "or", "other", "others", "otherwise", "ought", "our", "ours", "ourselves", "out", "outside", "over", "overall", "own", "p", "particular", "particularly", "per", "perhaps", "placed", "please", "plus", "possible", "presumably", "probably", "provides", "q", "que", "quite", "qv", "r", "rather", "rd", "re", "really", "reasonably", "regarding", "regardless", "regards", "relatively", "respectively", "right", "s", "said", "same", "saw", "say", "saying", "says", "second", "secondly", "see", "seeing", "seem", "seemed", "seeming", "seems", "seen", "self", "selves", "sensible", "sent", "serious", "seriously", "seven", "several", "shall", "she", "should", "shouldn't", "since", "six", "so", "some", "somebody", "somehow", "someone", "something", "sometime", "sometimes", "somewhat", "somewhere", "soon", "sorry", "specified", "specify", "specifying", "still", "sub", "such", "sup", "sure", "t", "t's", "take", "taken", "tell", "tends", "th", "than", "thank", "thanks", "thanx", "that", "that's", "thats", "the", "their", "theirs", "them", "themselves", "then", "thence", "there", "there's", "thereafter", "thereby", "therefore", "therein", "theres", "thereupon", "these", "they", "they'd", "they'll", "they're", "they've", "think", "third", "this", "thorough", "thoroughly", "those", "though", "three", "through", "throughout", "thru", "thus", "to", "together", "too", "took", "toward", "towards", "tried", "tries", "truly", "try", "trying", "twice", "two", "u", "un", "under", "unfortunately", "unless", "unlikely", "until", "unto", "up", "upon", "us", "use", "used", "useful", "uses", "using", "usually", "uucp", "v", "value", "various", "very", "via", "viz", "vs", "w", "want", "wants", "was", "wasn't", "way", "we", "we'd", "we'll", "we're", "we've", "welcome", "well", "went", "were", "weren't", "what", "what's", "whatever", "when", "whence", "whenever", "where", "where's", "whereafter", "whereas", "whereby", "wherein", "whereupon", "wherever", "whether", "which", "while", "whither", "who", "who's", "whoever", "whole", "whom", "whose", "why", "will", "willing", "wish", "with", "within", "without", "won't", "wonder", "would", "would", "wouldn't", "x", "y", "yes", "yet", "you", "you'd", "you'll", "you're", "you've", "your", "yours", "yourself", "yourselves", "z", "zero"]

  def self.normalize(string)
    result = string.downcase.gsub(/[-_\s]/, " ").squeeze(" ")[0, 255]

    if STOPWORDS.has_key?(result)
      STOPWORDS[result]
    else
      result
    end
  end

  def self.normalize(result, lang)
    result = result.downcase.split(/[,\.\\|\/:\s]+/) if result.class == String
    return [] if !result || result.count == 0

    if ["sk", "pl", "cz"].include? lang
      @@slovvak_stop_filter ||= Stopwords::Filter.new SLOVAKSTOPWORDS
      result = @@slovvak_stop_filter.filter result

    elsif lang != "exact"
      @@english_stop_filter ||= Stopwords::Filter.new ENGLISHSTOPWORDS
      result = @@english_stop_filter.filter result
    end

    result
  end


end