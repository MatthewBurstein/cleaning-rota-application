class Room
  attr_reader :room_name
  attr_accessor :chores
  def initialize(room_name, chores = [])
    @room_name = room_name
    @chores = chores

  end

  def show_chores
    return "The chores in this room are #{chores}"
  end

end
