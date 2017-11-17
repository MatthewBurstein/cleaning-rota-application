require_relative "classes/rota"
require_relative "classes/room"
require_relative "classes/housemate"
require "sqlite3"
require "CSV"

puts """
This wizard will help you create a cleaning rota for a shared house.

First, choose a name for your rota:
"""

  input = gets.chomp
  rota = Rota.new("#{input}")

  puts "the rota name is #{rota.name}"

puts """
Great! Now list up to 5 housemates living in the house. Names should be separated by semicolons.
"""

  housemates = gets.chomp.split(";").each do |person|
    person.strip!
  end

  housemates.map! { |name| Housemate.new(name) }

puts """
Amazing! Now provide a list of up to five rooms which need cleaning, separated by semicolons.
"""

  rooms = gets.chomp.split(";").each do |room|
    room.strip!
  end

puts """
Perfect! Now, for each room, please list up to five chores which need to be completed.
"""

#convert elements of rooms into variables

  rooms.map! { |room| Room.new(room) }

  rooms.each do |room|
    puts "Chores for #{room.name} separated by semicolons:"

    chores = gets.chomp.split(";").each do |chore|
      chore.strip!
    end
    room.chores = chores
  end

puts """
Great! Now that's done. I'll create the rota, assigning each housemate to a room for each week starting from this week.
"""

# shuffle rooms to ensure randomness

rooms.shuffle!

# assign rooms to housemates

housemates.each_with_index { |housemate, idx| housemate.rooms = rooms.rotate(idx) }

# printing to test
housemates.each do |housemate|
  room_names = housemate.rooms.map{ |room| room.name }.join(", ")
  puts "#{housemate.name} has these rooms #{room_names}"
end

#create general folder structure for rotas

parent_directory = "/Users/matt/Coding/Cleaning Rota App"

if !File.exist?("#{parent_directory}/rotas")
  Dir.chdir("#{parent_directory}") { |directory| Dir.mkdir("rotas")}
end

general_rotas_directory = "#{parent_directory}/rotas"

# create folder structure for this rota

if !File.exist?("#{general_rotas_directory}/#{rota.name}")
  Dir.chdir("#{general_rotas_directory}") { |directory| Dir.mkdir("#{rota.name}")}
end

Dir.chdir("#{general_rotas_directory}/#{rota.name}")

#create and write housemates and rooms to .csv

rota_csv = File.new("#{rota.name}_rota.csv", "w+")

CSV.open("#{rota.name}_rota.csv", "wb") do |csv|
  housemates.each do |housemate|
    csv << housemate.rooms.map { |room| room.name }.unshift(housemate.name)
  end
end

rota_csv.close

#create and write rooms and chores to .csv

rooms_csv = File.new("#{rota.name}_rooms.csv", "w+")

CSV.open("#{rota.name}_rooms.csv", "wb") do |csv|
  rooms.each do |room|
    csv << room.chores.unshift(room.name)
  end
end

rooms_csv.close
