require 'mechanize'

  class Job
    attr_reader :downloader

    def initialize(opts={})
      config      = opts[:config]     ||= \
                      Config.new(:filename => 'patent.yaml')
      @downloader = opts[:downloader] ||= \
            config.downloader_class.constantize.new(config)
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
