class BasicJob
  attr_reader :downloader

  def initialize(opts={})
    config = opts[:config] || JobConfig.new(:filename => 'patent.yaml')
    default_downloader = config.downloader_class.constantize.new(config)
    @downloader = opts[:downloader] || default_downloader
  end

  def run
    temp = @downloader.download_file
    rows = parse(temp)
    update_patents(rows)
  end

  def parse(temp)
    FasterCSV.read(temp, :headers => true)
  end

  def update_patents(rows)
    Patent.connection.transaction {
      Patent.delete_all
      rows.each {|r| Patent.create!(r.to_hash)}
    }
  end
end
