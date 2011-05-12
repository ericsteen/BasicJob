require "mechanize"

class GoogleAgent
  attr_reader :config

  def initialize(config)
    @config = config
  end

  def get_data
    temp = Tempfile.new(config.ftp_filename)
    tempname = temp.path
    temp.close
    Net::FTP.open(config.ftp_host, config.ftp_login, config.ftp_password) do |ftp|
      ftp.getbinaryfile(File.join(config.ftp_path, config.ftp_filename), tempname)
    end
    tempname
  end
end