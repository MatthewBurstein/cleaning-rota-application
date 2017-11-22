#below gives the required format for rspec
#to run the below, go to the spec folder and run rspec run_me_spec.rb

require "rspec"
require_relative "../lib/run_me"

describe RunMe do
  it "this test fails" do
    expect(RunMe.new.tester).to eq("I'm not a test")
  end
end
