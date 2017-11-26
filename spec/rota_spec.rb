require "rspec"
require_relative "../lib/classes/rota"

rota = Rota.new('rota')

describe Rota do
=begin
  it "get_housemates should output to stdout" do
    rota.housemates = ["sam", "matt", "john"]
    expect(rota.get_housemates).to eq("The housemates in this rota are sam, matt, john.")
  end
=end
  it "calculates the first Monday" do
    expect(rota.start_date).to eq(Date.today + 1)
  end

end
