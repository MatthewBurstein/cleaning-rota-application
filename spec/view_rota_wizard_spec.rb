require "rspec"
require_relative "../lib/classes/rota"
require_relative "../lib/view_rota_wizard"

wizard = ViewRotaWizard.new
wizard.rota = Rota.new("MyRota")
wizard.rota.directory = "/Users/matt/Coding/Cleaning Rota App/rotas"
wizard.slurp_rota_csv # used for testing
wizard.slurp_rooms_csv # used for testing


describe ViewRotaWizard do

  it "should return the current week" do
    expect(wizard.view_current_week).to eq(0)
  end

end
