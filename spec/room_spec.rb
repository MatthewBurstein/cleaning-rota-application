require "rspec"
require "room"

describe Room do
  before :each do
    @room = room.new("first chore", "second chore", "third chore")
  end

  it "takes 3 parameters and returns an instance of room" do
    @room.should_be_an_instance_of Room
  end
end
