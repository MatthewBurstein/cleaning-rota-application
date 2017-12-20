require "rspec"
require_relative "../lib/classes/rota"



describe Rota do
  before {
    allow(Date).to receive(:today).and_return Date.new(2001,2,3)
  }

=begin
  it "get_housemates should output to stdout" do
    rota.housemates = ["sam", "matt", "john"]
    expect(rota.get_housemates).to eq("The housemates in this rota are sam, matt, john.")
  end

  it "calculates the first Monday" do
    expect(rota.start_date).to eq(Date.today + 1)
  end
=end
  it "" do
    rota = Rota.new('rota', 1)
    expect(rota.list_of_weeks_by_monday_date).to eq([Date.new(2001,2,3).next_monday])
  end
end
