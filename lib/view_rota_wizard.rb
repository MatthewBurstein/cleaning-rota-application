require "CSV"
require_relative "classes/rota"
require_relative "classes/room"
require_relative "classes/housemate"
require_relative "core_additions"

class ViewRotaWizard
  attr_accessor :rota

  def initialize
  end

  def init_view_rota
    puts "This wizard will hep you view and update an existing rota.\nFirst, indicate the name of the rota you would like to view."
    @rota = Rota.new("#{gets.chomp}")
    @rota.directory = "/Users/matt/Coding/Cleaning Rota App/rotas"
    #puts "what would you like to do?"
  end

  def slurp_rota_csv #opens and converts to useable format
    #puts "#{@rota.directory}/#{@rota.name}/#{@rota.name}_rota.csv"
    csv = CSV.read("#{@rota.directory}/#{@rota.name}/#{@rota.name}_rota.csv", return_headers:false)
    #extract dates and convert to Date
    @rota.date_list = csv.shift.drop(1).map! do |date|
      Date.strptime(date.gsub!("w/c ", ""), "%d %b %y")
    end
    csv.map do |row|
      housemate = Housemate.new(row.shift) #convert names to objects
      housemate.rooms = row #assign rooms to housemate objects
      @rota.housemates << housemate #create array of housemate objects
    end
    #puts @rota.housemates[0].rooms #used for debugging
    #puts @rota.date_list #used for debugging
  end

  def slurp_rooms_csv #opens and converts to useable format
    csv = CSV.read("#{@rota.directory}/#{@rota.name}/#{@rota.name}_rooms.csv", return_headers:false)
    rooms_headers = csv.shift # remove headers
    csv.map do |row|
      room = Room.new(row.shift) #convert names to objects
      room.chores = row #assign chores to room objects
      @rota.rooms << room #create array of room objects
    end
     #puts "#{@rota.rooms[0].name} has these chores: #{@rota.rooms[0].chores}" #used for testing
  end

  def what_to_do
  end

  def get_housemates
    @rota.get_housemates
  end

  def get_rooms
    @rota.get_rooms
  end

  def view_current_week
    last_monday = Date.today.next_monday - 7
    idx = @rota.date_list.find_index(last_monday)
    this_week = {}
    @rota.housemates.each do |housemate|
      this_week[housemate.name] = housemate.rooms[idx]
    end
    puts this_week
  end

  def edit_housemates
  end

  def edit_rooms
  end

end

# everything below is used only for testing

wizard = ViewRotaWizard.new
wizard.rota = Rota.new("MyRota")
wizard.rota.directory = "/Users/matt/Coding/Cleaning Rota App/rotas"
wizard.slurp_rota_csv
wizard.slurp_rooms_csv
#wizard.get_housemates
#wizard.get_rooms
wizard.view_current_week
