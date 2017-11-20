require "CSV"
require_relative "classes/rota"
require_relative "classes/room"
require_relative "classes/housemate"

class ViewRotaWizard
  attr_accessor :rota
  attr_reader :directory

  def initialize(rota)
    @rota = rota
    @directory = "/Users/matt/Coding/Cleaning Rota App/rotas"
    @housemates = []
    @rooms = []
    #puts "what would you like to do?"
  end

  def slurp_rota_csv #opens and converts to useable format
    csv = CSV.read("#{@directory}/#{@rota}/#{@rota}_rota.csv", return_headers:false)
    rota_headers = csv.shift #remove headers
    csv.map do |row|
      housemate = Housemate.new(row.shift) #convert names to objects
      housemate.rooms = row #assign rooms to housemate objects
      @housemates << housemate #create array of housemate objects
    end
    #puts @housemates[0].rooms #used for debugging
  end

  def slurp_rooms_csv #opens and converts to useable format
    csv = CSV.read("#{@directory}/#{@rota}/#{@rota}_rooms.csv", return_headers:false)
    rooms_headers = csv.shift # remove headers
    csv.map do |row|
      room = Room.new(row.shift) #convert names to objects
      room.chores = row #assign chores to room objects
      @rooms << room #create array of room objects
    end
    # puts "#{@rooms[0].name} has these chores: #{@rooms[0].chores}" #used for testing
  end

  def close_rota_csv
  end

  def close_rooms_csv
  end

  def what_to_do
  end

  def get_housemates
  end

  def get_rooms
  end

  def view_current_week
  end

  def edit_housemates
  end

  def edit_rooms
  end

end

rota = ViewRotaWizard.new("MyRota")
# rota.slurp_rota_csv # used for debugging
rota.slurp_rooms_csv



=begin
general_rotas_directory = "/Users/matt/Coding/Cleaning Rota App/rotas"

puts """
What is the name of the rota you would like to view?
"""

rota_name = gets.chomp

puts Dir.exist?("#{general_rotas_directory}/rotas/#{rota_name}")
=end
