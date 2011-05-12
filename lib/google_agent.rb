require "mechanize"

class GoogleAgent
  attr_reader :config

  def initialize(config)
    @config = config
  end

  def get_data
    agent = Mechanize.new
    agent.get("http://www.google.com")  
    google_form = page.form('f')
    google_form.q = 'ruby mechanize'
    agent.page.submit(google_form)
    agent.page.search(".search_result_item").each do |result|
      Entity.create!(:name => result.text.strip)
    end
  end
end