require_relative "rota"
require_relative "room"
require_relative "housemate"
require "sqlite3"
require "CSV"

puts """
This wizard will help you create a cleaning rota for a shared house.

First, choose a name for your rota:
"""

  input = gets.chomp
  rota = Rota.new("#{input}")

  puts "the rota name is #{rota}"

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

  rooms.each do |room|
    puts "Chores for #{room.room_name} separated by semicolons:"

    chores = gets.chomp.split(";").each do |chore|
      chore.strip!
    end
    room.chores = chores
  end

puts """
Great! Now that's done. I'll create the rota, assigning each housemate to a room for each week starting from this week.
"""

# shuffle rooms to ensure randomness

rooms.shuffle!.map! { |room| Room.new(room) }

# assign rooms to housemates

housemates.each_with_index { |housemate, idx| housemate.rooms = rooms.rotate(idx) }

# printing to test
housemates.each do |housemate|
  room_names = housemate.rooms.map { |room| room.room_name}.join(", ")
  puts "#{housemate.name} has these rooms #{room_names}"
end

#create and write housemates and rooms to .csv

rota_csv = File.new("#{rota.name}_rota.csv", "w+")

CSV.open("#{rota.name}_rota.csv", "wb") do |csv|
  housemates.each do |housemate|
    csv << housemate.rooms.map { |room| room.room_name }.unshift(housemate.name)
  end
end

rota_csv.close
