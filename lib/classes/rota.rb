require_relative "housemate"
require_relative "room"
require "Date"

class Rota
  attr_accessor :name, :start_date, :length, :directory, :rooms, :housemates
  def initialize(name, length = 0)
    @name = name
    @start_date = first_monday(Date.today)
    @length = length #in weeks
    @directory = ""
    @rooms = []
    @housemates = []
  end

  def get_housemates
    puts "The housemates in this rota are #{@housemates.join(", ")}."
  end

  def get_rooms
    puts "The rooms in this rota are #{@rooms.join(", ")}."
  end

  private

  def first_monday (date)
    while !date.monday?
      date += 1
    end
    date
  end


end


# Weekly payment instance variable
