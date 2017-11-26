#below gives the required format for rspec
#to run the below, go to the spec folder and run rspec run_me_spec.rb

require "rspec"
require_relative "../lib/create_rota_wizard"

test_rota = CreateRotaWizard.new
test_rota.housemates = ["hm1", "hm2", "hm3"]
test_rota.rooms = ["rm1", "rm2", "rm3"]


describe CreateRotaWizard do
  it "rota_length divisible by number of rooms" do
    test_rota.rota.length = 30
    expect(test_rota.full_length_rota).to eq(["rm1", "rm2", "rm3"] * 10)
  end

  it "rota_length not divisble by number of rooms" do
    test_rota.rota.length = 31
    expect(test_rota.full_length_rota).to eq((["rm1", "rm2", "rm3"] * 10).push("rm1"))
  end


end
