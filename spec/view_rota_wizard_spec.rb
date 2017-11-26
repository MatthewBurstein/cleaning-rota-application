require "rspec"
require_relative "../lib/classes/rota"
require_relative "../lib/view_rota_wizard"

this_rota = ViewRotaWizard.new
this_rota.rota = Rota.new("MyRota")
this_rota.slurp_rota_csv # used for testing
this_rota.slurp_rooms_csv # used for testing


describe ViewRotaWizard do




end
