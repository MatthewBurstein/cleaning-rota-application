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
    puts "\nThis wizard will hep you view and update an existing rota.\n"
    loop do
      puts "\nPlease indicate the name of the rota you would like to view.\n"
      rota_name = gets.chomp
      @rota = Rota.new("#{rota_name}")
      set_directory
      if (File.exist?("#{@rota.directory}/#{rota_name}/#{rota_name}_rota.csv") && File.exist?("#{@rota.directory}/#{rota_name}/#{rota_name}_rooms.csv"))
        puts "\nThanks. I've found the database\n\n"
        breaker = true
      else
        puts "\nThere is not a valid rota with that name.\n\n"
        breaker = false
      end
      break if breaker
    end
    slurp_rota_csv
    slurp_rooms_csv
    what_to_do
  end

  def set_directory
    @rota.directory = "/Users/matt/Coding/Cleaning Rota App/rotas"
  end

  def slurp_rota_csv #opens and converts to useable format
    #puts "#{@rota.directory}/#{@rota.name}/#{@rota.name}_rota.csv"
    csv = CSV.read("#{@rota.directory}/#{@rota.name}/#{@rota.name}_rota.csv", return_headers:false)
    #extract dates and convert to Date
    @rota.list_of_weeks_by_monday_date = csv.shift.drop(1).map! do |date|
      Date.strptime(date.gsub!("w/c ", ""), "%d %b %y")
    end
    csv.map do |row|
      housemate = Housemate.new(row.shift) #convert names to objects
      housemate.rooms = row #assign rooms to housemate objects
      @rota.housemates << housemate #create array of housemate objects
    end
    #puts @rota.housemates[0].rooms #used for debugging
    #puts @rota.list_of_weeks_by_monday_date #used for debugging
  end

  def slurp_rooms_csv #opens and converts to useable format
    csv = CSV.read("#{@rota.directory}/#{@rota.name}/#{@rota.name}_rooms.csv", return_headers:false)
    csv.drop(1).map do |row|
      room = Room.new(row.shift) #convert names to objects
      room.chores = row #assign chores to room objects
      @rota.rooms << room #create array of room objects
    end
     #puts "#{@rota.rooms[0].name} has these chores: #{@rota.rooms[0].chores}" #used for testing
  end

  def what_to_do
    puts "\nWhat would you like to do?\n\t
      1. View the current week\n\t
      2. List housemates\n\t
      3. List rooms\n\t
      4. Edit housemates (incomplete)\n\t
      5. Edit rooms (incomplete)\n\t
      6. Edit chores\n\t
      7. Exit
      "
      choice = gets.chomp
      case choice
      when "1"
        view_current_week
      when "2"
        get_housemates
      when "3"
        get_rooms
      when "6"
        edit_chores
      when "7"
        exit(true)
      end
  end

  def continue?
      puts "Would you like to continue?\n\t
      1. Yes\n\t
      2. No\n\t"
      input = gets.chomp
      case input
      when "1"
        what_to_do
      when "2"
        exit(true)
      else
        puts "I don't understand, please try again"
        continue?
      end
  end

  def view_current_week
    last_monday = Date.today.next_monday - 7
    idx = @rota.list_of_weeks_by_monday_date.find_index(last_monday)
    this_week = Hash.new
    @rota.housemates.each do |housemate|
      this_week[housemate.name] = housemate.rooms[idx]
    end
    puts "\n#{this_week}\n"
    continue?
  end

  def get_housemates
    @rota.get_housemates
    continue?
  end

  def get_rooms
    @rota.get_rooms
    continue?
  end

  def get_chores
  end

  def edit_housemates
  end

  def edit_rooms
  end

  def edit_chores
    indexes = []
    rooms_without_null = @rota.rooms.reject{ |room| room.name == "no_room"}
    puts "Which room would you like to edit?\n\t"
    rooms_without_null.each_with_index do |room, idx|
      puts "#{idx + 1}. #{room.name.capitalize}\n\t"
      indexes << (idx + 1).to_s
    end
    choice = gets.chomp
    if indexes.include?(choice)
      this_room = rooms_without_null[choice.to_i - 1]
      puts "The current chores for #{this_room.name} are #{this_room.chores}.\n\t
      Please list new chores separated by semicolons."
      this_room.chores = gets.chomp.custom_to_a
      puts "I have updated the room for you."
      continue?
    else
      puts "I do not understand that input\n\t"
      edit_chores
    end
  end

end

# everything below is used only for testing

#wizard = ViewRotaWizard.new
#wizard.rota = Rota.new("MyRota")
#wizard.rota.directory = "/Users/matt/Coding/Cleaning Rota App/rotas"
#wizard.slurp_rota_csv
#wizard.slurp_rooms_csv
#wizard.what_to_do
#wizard.get_housemates
#wizard.get_rooms
#wizard.view_current_week
#wizard.edit_chores
