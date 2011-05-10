require 'spec_helper'

describe BasicJob do
  it "should be valid" do
    BasicJob.should be_a(Module)
  end
end