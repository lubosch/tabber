class User < ActiveRecord::Base
  self.table_name = 'User'
  acts_as_authentic

  has_many :log_softwares
  has_many :log_songs
  has_many :songs, :through => :log_songs
  has_many :log_movies
  has_many :words
  has_many :word_texts, :through => :words
  has_many :word_headings, :through => :words


  attr_accessible :name, :email, :pass, :token, :annota_id, :pc_uniq, :ip
  before_validation :reset_persistence_token, :if => :persistence_token?

  def last_log
    log_softwares.order('timestamp DESC').first
  end

  def last_log_software(time)
    log_softwares.timestamp_within(time).joins('JOIN Log_Software ls ON ls.id = (SELECT TOP 1 id FROM Log_software ls WHERE [Log_software].timestamp < ls.timestamp AND [Log_software].user_id = ls.user_id ORDER BY timestamp)').where("DATEDIFF(second, [Log_software].timestamp, ls.timestamp) > 5 AND [log_software].software_id NOT IN (?)", Software.where(:ignore => 1))
  end

  def last_log_software_tabber(time)
    grouped_logs = log_softwares.timestamp_within(time).joins('JOIN Log_Software ls ON ls.id = (SELECT TOP 1 id FROM Log_software ls WHERE [Log_software].timestamp < ls.timestamp AND [Log_software].user_id = ls.user_id ORDER BY timestamp)').where("DATEDIFF(second, [Log_software].timestamp, ls.timestamp) > 30").select("[Log_Software].software_id section_id, [Log_Software].softwareWindowName text, [Log_Software].timestamp start_date, ls.timestamp end_date").order("start_date")
    #grouped_logs = process_logs(logs)
    ids = grouped_logs.map { |l| l["section_id"] }.uniq
    ids = Software.where(:id => ids).select("[id] [key], name label").as_json
    start_date =grouped_logs.first["start_date"]
    end_date =grouped_logs.last["end_date"]
    x_size = calc_x_size start_date, end_date
    real_size = calc_real_size start_date, end_date

    result = {:logs => grouped_logs, :labels => ids, :start_date => start_date, :end_date => end_date, :x_size => x_size, :real_size => real_size}

    result
  end

  def context(hours_ago, end_date)
    context = {}
    context = context_logs(hours_ago, end_date, context)
    context = context_songs(hours_ago, end_date, context)
    context = context_videos(hours_ago, end_date, context)
    context = context_word(hours_ago, end_date, context)


    context
  end

  def context_logs(hours_ago, end_date, context)
    logs = LogSoftware.includes(:software).where('timestamp > ? AND timestamp < ? AND user_id = ? AND [Software].ignore <>1 ', hours_ago.hours.ago(end_date), end_date, self.id).order(:timestamp)

    (1...logs.size).each do |i|
      if !logs[i-1].length
        logs[i-1].length = logs[i].timestamp - logs[i-1].timestamp
        logs[i-1].save
      end
    end

    context_from_logs logs, context
  end

  def context_songs(hours_ago, end_date, context)
    logs = log_songs.includes(:song, :software).where("started > ? AND started < ?", hours_ago.hours.ago(end_date), end_date)
    context_from_logs logs, context
  end

  def context_videos(hours_ago, end_date, context)
    logs = log_movies.includes({:movie => :software}, :software).where("started > ? AND started < ?", hours_ago.hours.ago(end_date), end_date)
    context_from_logs(logs, context)

  end

  def context_from_logs(logs, context)
    logs.each do |log|
      context[log.id_name] ||= {}
      context[log.id_name][:keywords] ||= [{:keywords => log.id_name, :type => "AppName"}]
      context[log.id_name][:keywords] << log.keywords
    end
    context.each_key { |name| context[name].delete nil }
    context
  end


  def context_word (hours_ago, end_date, context)
    logs = word_texts.includes(:word).where("[Text_Word].timestamp > ? AND [Text_Word].timestamp < ?", hours_ago.hours.ago(end_date), end_date)
    texts = context_from_logs logs, context

    logs = word_headings.includes(:word).where('[Heading_Word].timestamp > ? AND [Heading_Word].timestamp < ?', hours_ago.hours.ago(end_date), end_date)
    headings = context_from_logs logs, context

    #binding.pry

    context
    #texts
  end

  def calc_x_size(start_date, end_date)
    ((end_date-start_date)/60 -50).ceil
  end


  def calc_real_size(start_date, end_date)
    ((end_date-start_date)/60*19).ceil
  end


  def process_logs(logs)

    i=1
    while i<grouped_logs.count do
      if grouped_logs[i]["section_id"] == grouped_logs[i-1]["section_id"]
        grouped_logs.delete(grouped_logs[i])
      else
        grouped_logs[i-1]["end_date"] = grouped_logs[i]["start_date"]
        i+=1
      end
    end

    grouped_logs
  end

  def last_softwares_id(time)
    last_log_software(time).group("[Log_Software].software_id").select("MAX([Log_Software].timestamp) stopa, [Log_Software].software_id ,sum(DATEDIFF(second, [Log_software].timestamp, ls.timestamp)) pocet").order("SUM(DATEDIFF(second, [Log_software].timestamp, ls.timestamp)) DESC").limit(5)
  end

  def last_software_names(time)
    last_software(time).select(:softwareWindowName)
  end


  def last_software(time)
    logs = LogSoftware.joins(:software).joins("JOIN (#{last_softwares_id(time).to_sql}) lss ON lss.stopa=timestamp").select("[Log_Software].id, name, pocet,softwareWindowName").order(:pocet).reverse_order
    logs.each { |log| log.softwareWindowName = log["name"] if log.softwareWindowName.to_s == "" }
  end

  def update_ip(his_ip)
    if (!self.ip)
      self.ip = his_ip
      self.email = rand(21353554).to_s + "@unknown.com" if !self.email
      save!
    end
  end

  def persistence_token?
    if persistence_token.nil?
      true
    else
      false
    end
  end

  def up_token
    generate_token(:persistence_token)
    save

  end

  def reset_persistence_token
    generate_token(:persistence_token)
  end


  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end


end


#SELECT * from Software s JOIN
#(
#--	SELECT  top 5 [Log_Software].software_id ,count([Log_Software].software_id) pocet
#SELECT  top 5 [Log_Software].software_id ,sum(DATEDIFF(second, [Log_software].timestamp, ls.timestamp)) pocet
#--	SELECT  *
#
#    FROM [Log_Software]
#JOIN Log_Software ls
#ON ls.id =
#       (
#       SELECT TOP 1 id
#       FROM Log_software ls
#       WHERE [Log_software].timestamp < ls.timestamp AND [Log_software].user_id = ls.user_id
#       ORDER BY timestamp
#       )
#WHERE [Log_Software].[user_id] = 6 AND
#([Log_software].timestamp > '2014-01-29 15:40:05.157') AND
#(DATEDIFF(second, [Log_software].timestamp, ls.timestamp) > 5)
#GROUP BY [Log_Software].software_id
#ORDER BY sum(DATEDIFF(second, [Log_software].timestamp, ls.timestamp)) DESC
#)  	lss ON lss.software_id = id
#

