class Room
  attr_reader :chore_array
  def initialize(chore_array)
    @chore_array = chore_array

  end

  def show_chores
    return "The chores in this room are #{chore_array}"
  end

end
