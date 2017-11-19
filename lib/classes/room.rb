class Room
  attr_reader :name
  attr_accessor :chores
  def initialize(name, chores = [])
    @name = name
    @chores = chores
  end

  def number_of_chores
    chores.length
  end

  def show_chores
    return "The chores in this room are #{chores}"
  end

end
