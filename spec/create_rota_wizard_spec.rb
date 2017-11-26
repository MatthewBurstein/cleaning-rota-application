#below gives the required format for rspec
#to run the below, go to the spec folder and run rspec run_me_spec.rb

require "rspec"
require_relative "../lib/create_rota_wizard"

wizard = CreateRotaWizard.new
wizard.rota = Rota.new("rota")
wizard.rota.housemates = ["hm1", "hm2", "hm3"]
wizard.rota.rooms = ["rm1", "rm2", "rm3"]


describe CreateRotaWizard do
  it "rota_length divisible by number of rooms" do
    wizard.rota.length = 30
    expect(wizard.calculate_full_rota_rooms).to eq(["rm1", "rm2", "rm3"] * 10)
  end

  it "rota_length not divisble by number of rooms" do
    wizard.rota.length = 31
    expect(wizard.calculate_full_rota_rooms).to eq((["rm1", "rm2", "rm3"] * 10).push("rm1"))
  end




end
