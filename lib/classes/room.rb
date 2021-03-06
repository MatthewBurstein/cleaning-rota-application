class Room
  attr_accessor :name, :chores
  def initialize(name, chores = ["no_chores"])
    @name = name
    @chores = chores
  end

  def number_of_chores
    chores.length
  end

  def show_chores
    return "The chores in this room are #{chores}"
  end

  def to_s
    @name
  end
end
