require_relative "housemate"
require_relative "room"
require_relative "../core_additions"
require "Date"

class Rota
  attr_accessor :name, :start_date, :length, :directory, :rooms, :date_list, :housemates
  def initialize(name, length = 0)
    @name = name
    @start_date = Date.today.next_monday
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

  def next_monday
    @start_date
  end

end


# Weekly payment instance variable
