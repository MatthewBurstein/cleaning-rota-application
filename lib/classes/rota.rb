require_relative "housemate"
require_relative "room"
require_relative "../core_additions"
require "Date"

class Rota
  attr_accessor :name, :length, :directory, :rooms, :list_of_weeks_by_monday_date, :housemates
  attr_reader :start_date
  def initialize(name, length = 0)
    @name = name
    @start_date = Date.today.next_monday
    @length = length #in weeks
    @directory = ""
    @rooms = []
    @housemates = []
    @list_of_weeks_by_monday_date = []
  end

  def list_of_weeks_by_monday_date
    date = @start_date
    array_of_mondays =[]
    @length.times do
      array_of_mondays << date
      date += 7
    end
    array_of_mondays
  end

  def get_housemates
    puts "The housemates in this rota are #{@housemates.join(", ")}."
  end

  def get_rooms
    rooms_without_null = @rooms.reject{ |room| room.name == "no_room"}
    puts "The rooms in this rota are #{rooms_without_null.join(", ")}."
    rooms_without_null.each do |room|
      puts "\t#{room.name}\n"
      room.chores.each do |chore|
        puts "\t  - #{chore}"
      end
      puts "\n"
    end
  end

  def next_monday
    @start_date
  end

end


# Weekly payment instance variable
