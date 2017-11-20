require_relative "classes/rota"
require_relative "classes/room"
require_relative "classes/housemate"
require "CSV"

class CreateRotaWizard
  attr_accessor :rota, :housemates, :rooms
  def initialize
    init_create_rota #create @rota
    create_housemates #create @housemates
    create_rooms #create @rooms
    create_chores(@rooms)
    assign_rooms(@housemates, @rooms)
    create_folder_structure(@rota)
    create_housemates_csv(@rota, @housemates, @rooms)
    create_rooms_csv(@rota, @rooms)
  end

  private

  def init_create_rota
    puts "This wizard will help you create a cleaning rota for a shared house.\nFirst, choose a name for your rota:"
    input = gets.chomp
    @rota = Rota.new("#{input}")
    puts "You are create the rota '#{rota.name}'."
  end

  def create_housemates
    puts "Great! Now list up to 5 housemates living in the house. Names should be separated by semicolons."
    housemates = gets.chomp.split(";").each do |person|
      person.strip!
    end
    @housemates = housemates.map! { |name| Housemate.new(name) }
  end

  def create_rooms
    puts "Amazing! Now provide a list of up to five rooms which need cleaning, separated by semicolons."
    rooms = gets.chomp.split(";").each do |room|
      room.strip!
    end
    rooms.map! { |room| Room.new(room) } #convert elements of rooms into variables
    @rooms = rooms.shuffle! # shuffle rooms to ensure randomness
  end

  def create_chores(rooms)
    puts "Perfect! Now, for each room, please list up to five chores which need to be completed."
    rooms.each do |room|
      puts "Chores for #{room.name} separated by semicolons:"
      chores = gets.chomp.split(";").each do |chore|
        chore.strip!
      end
      room.chores = chores
    end
    puts "Great! Now that's done. I'll create the rota, assigning each housemate to a room for each week starting from this week."
  end

  def assign_rooms(housemates, rooms)
    housemates.each_with_index { |housemate, idx| housemate.rooms = rooms.rotate(idx)} # assign rooms to housemates
    housemates.each do |housemate|
      room_names = housemate.rooms.map{ |room| room.name }.join(", ")
      puts "#{housemate.name} has will clean rooms in the following order: #{room_names}"
    end
  end

  def create_folder_structure(rota)
    parent_directory = "/Users/matt/Coding/Cleaning Rota App"
    general_rotas_directory = "#{parent_directory}/rotas"
    #create parent rota directory
    if !File.exist?("#{parent_directory}/rotas")
      Dir.chdir("#{parent_directory}") { |directory| Dir.mkdir("rotas")}
    end
    # create folder structure for this rota
    if !File.exist?("#{general_rotas_directory}/#{rota.name}")
      Dir.chdir("#{general_rotas_directory}") { |directory| Dir.mkdir("#{rota.name}")}
    end
    Dir.chdir("#{general_rotas_directory}/#{rota.name}")
  end

  def create_housemates_csv(rota, housemates, rooms)
    # Result is .csv with headers "housemates" and dates in form "1 Jan".
    # All other rows are in form housmate_name,first_room,second_room,...
    # Prepare header row
    rota_csv_headers = ["Housemate"]
    (rooms.length).times do
      current_date = rota.start_date
      rota_csv_headers << "w/c #{current_date.strftime("%d %b")}"
      current_date += 7
    end
    # Create and complete CSV
    rota_csv = File.new("#{rota.name}_rota.csv", "w+")
    CSV.open("#{rota.name}_rota.csv", "wb", headers:true) do |csv| # Add rows to .csv
      csv << rota_csv_headers
      housemates.each do |housemate|
        csv << housemate.rooms.map { |room| room.name }.unshift(housemate.name)
      end
    end
    rota_csv.close
  end

  def create_rooms_csv(rota, rooms)
    # Result is .csv with headers Room,Chore_1,Chore_2,Chore_3...
    # Rows list the chores for each room
    # Prepare Header row
    max_chores = rooms.max_by{ |room| room.number_of_chores}.number_of_chores
    rooms_csv_headers = ["Room"]
    (1..max_chores).each do |i|
      rooms_csv_headers << "Chore #{i}"
    end
    # Create and complete csv
    rooms_csv = File.new("#{rota.name}_rooms.csv", "w+")
    CSV.open("#{rota.name}_rooms.csv", "wb", headers:true) do |csv|
      csv << rooms_csv_headers
      rooms.each do |room|
        csv << room.chores.unshift(room.name)
      end
    end
    rooms_csv.close
  end
end

CreateRotaWizard.new # Used to test class
