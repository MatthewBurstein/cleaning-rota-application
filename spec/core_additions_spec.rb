require "rspec"
require_relative "../lib/core_additions"


describe Date do
  it "should give the next Monday" do
    expect(Date.today.next_monday).to eq(Date.today + 1)
  end
end
