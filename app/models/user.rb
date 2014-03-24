class User < ActiveRecord::Base
  self.table_name = 'User'
  acts_as_authentic

  has_many :log_softwares


  attr_accessible :name, :email, :pass, :token, :annota_id, :pc_uniq, :ip
  before_validation :reset_persistence_token, :if => :persistence_token?

  def last_log
    log_softwares.order('timestamp DESC').first
  end

  def last_log_software(time)
    log_softwares.timestamp_within(time).joins('JOIN Log_Software ls ON ls.id = (SELECT TOP 1 id FROM Log_software ls WHERE [Log_software].timestamp < ls.timestamp AND [Log_software].user_id = ls.user_id ORDER BY timestamp)').where("DATEDIFF(second, [Log_software].timestamp, ls.timestamp) > 5 AND [log_software].software_id NOT IN (?)", Software.where(:ignore => 1))

  end

  def last_softwares_id(time)
    last_log_software(time).group("[Log_Software].software_id").select("MAX([Log_Software].timestamp) stopa, [Log_Software].software_id ,sum(DATEDIFF(second, [Log_software].timestamp, ls.timestamp)) pocet").order("SUM(DATEDIFF(second, [Log_software].timestamp, ls.timestamp)) DESC").limit(5)
  end

  def last_software_names(time)
    last_software(time).select(:softwareWindowName)
  end


  def last_software(time)
    LogSoftware.joins(:software).joins("JOIN (#{last_softwares_id(time).to_sql}) lss ON lss.stopa=timestamp").select("[Log_Software].id, name, pocet,softwareWindowName").order(:pocet).reverse_order
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

