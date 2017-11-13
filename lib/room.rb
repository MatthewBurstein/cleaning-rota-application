class Room
  attr_reader :room_name
  attr_accessor :chore_array
  def initialize(room_name, chore_array)
    @room_name = room_name
    @chore_array = chore_array

  end

  def show_chores
    return "The chores in this room are #{chore_array}"
  end

end
