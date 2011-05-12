require 'spec_helper'
require 'job_config'

describe JobConfig do

  it "loads the yaml file" do
    config = JobConfig.new(:filename => 'patent.yml', :env => "test")
    config.data.should include "test"=>{"foo"=>"bar"}
  end

#  it "should return the right path" do
#    JobConfig.config_path.should == "../config/external_resources"
#  end

end