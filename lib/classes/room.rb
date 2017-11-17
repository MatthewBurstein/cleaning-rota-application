class Room
  attr_reader :name
  attr_accessor :chores
  def initialize(name, chores = [])
    @name = name
    @chores = chores

  end

  def show_chores
    return "The chores in this room are #{chores}"
  end

end
