require_relative "classes/rota"
require_relative "classes/room"
require_relative "classes/housemate"
require "CSV"


class CreateRotaWizard
  attr_accessor :rota
  def initialize
    init_create_rota #create @rota
    create_housemates #create @housemates
    create_rooms #create @rooms
    create_chores(@rota.rooms)
    assign_rooms(@rota, @rota.rooms, @rota.housemates)
    create_folder_structure(@rota)
    create_housemates_csv(@rota, @rota.housemates)
    create_rooms_csv(@rota, @rota.rooms)
    puts "Congratulations. Your rota has been created."
  end

  private

  def init_create_rota
    puts "This wizard will help you create a cleaning rota for a shared house.\nFirst, choose a name for your rota:"
    @rota = Rota.new("#{gets.chomp}")
    puts "how many weeks would you like this rota to run for?"
    @rota.length = gets.chomp.to_i
    puts "You are creating the rota '#{@rota.name}'. which will run for #{@rota.length} weeks"
  end

  def create_housemates
    puts "Great! Now list the housemates living in the house. Names should be separated by semicolons."
    housemates = gets.chomp.custom_to_a
    @rota.housemates = housemates.map! { |name| Housemate.new(name) }
  end

  def create_rooms
    puts "Amazing! Now provide a list of rooms which need cleaning, separated by semicolons."
    rooms = gets.chomp.custom_to_a
    if @rota.housemates.length > rooms.length #if more housemates than rooms, pad @rooms with null values.
      (@rota.housemates.length - rooms.length).times do
        rooms << "no_room"
      end
    end
    rooms.map! { |room| Room.new(room) } #convert elements of rooms into variables
    @rota.rooms = rooms
  end

  def create_chores(rooms)
    puts "Perfect! Now, for each room, please the chores which need to be completed."
    rooms.each do |room|
      if room.name != "no_room" #if null room then leave chores as default, "no_chores"
        puts "Chores for #{room.name} separated by semicolons:"
        chores = gets.chomp.custom_to_a
        room.chores = chores
      end
    end
    puts "Great! Now that's done. I'll create the rota, assigning each housemate to a room for each week starting from this week."
  end

  def calculate_full_rota_rooms(rota, rooms)
    num_complete_rooms = (rota.length / rooms.length)
    remainder = rota.length % rooms.length
    housemate_rota = rooms * num_complete_rooms
    remainder.times do |i|
      housemate_rota.push(rooms[i])
    end
    housemate_rota
  end

  def assign_rooms(rota, rooms, housemates)
    rooms.shuffle! # shuffle rooms to ensure randomness of assignment
    housemates.each_with_index do |housemate, idx|
      housemate.rooms = calculate_full_rota_rooms(rota, rooms).rotate(idx)
    end # assign rooms to housemates
    housemates.each do |housemate| #print first full list of rooms for each housemate
      room_names = housemate.rooms.map{ |room| room.name }.slice(0, rota.rooms.length).join(", ")
      puts "#{housemate.name} will clean rooms in the following order: #{room_names}"
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

  def create_housemates_csv(rota, housemates)
    # Result is .csv with headers "housemates" and dates in form "1 Jan 17".
    # All other rows are in form housmate_name,first_room,second_room,...
    # Prepare header row
    rota_csv_headers = ["Housemate"]
    date = rota.start_date
    (rota.length).times do
      rota_csv_headers << "w/c #{date.strftime("%d %b %y")}"
      date += 7
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
    # Each row is a list of the chores for one room
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

#CreateRotaWizard.new # Used to test class
