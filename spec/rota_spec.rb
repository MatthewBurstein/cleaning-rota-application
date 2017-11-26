require "rspec"
require_relative "../lib/classes/rota"

describe Rota do
  it "get_housemates should output to stdout" do
    rota = Rota.new('rota')
    rota.housemates = ["sam", "matt", "john"]
    expect(rota.get_housemates).to eq("The housemates in this rota are sam, matt, john.")
  end
end
