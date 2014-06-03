class Skriptik
  def fix_encoding
    LogSoftware.find(:all).each do |ls|
      begin
        #encoded = ls.softwareWindowName.encode("windows-1250", :undefined => :replace, :replace => "").force_encoding('utf-8')
        if encoded.valid_encoding? && encoded != ls.softwareWindowName
          ls.softwareWindowName = encoded
          ls.save
        end
      rescue Exception => ex
        #binding.pry
      end
    end
  end
end