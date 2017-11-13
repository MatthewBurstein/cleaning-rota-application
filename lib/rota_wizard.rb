require_relative "rota"
require_relative "room"
require_relative "housemate"
require "sqlite3"

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

puts """
Amazing! Now provide a list of up to five rooms which need cleaning, separated by semicolons.
"""

  rooms = gets.chomp.split(";").each do |room|
    room.strip!
  end

puts """
Perfect! Now, for each room, please list the chores which need to be completed.
"""

  rooms_chores = {}
  rooms.each do |room|
    puts "Chores for #{room} separated by semicolons:"

    rooms_chores["#{room}"] = gets.chomp.split(";").each do |chore|
                  chore.strip!
                end
    end


puts """
Great! Now that's done. I'll create the rota, assigning each housemate to a room for each week starting from this week.
"""

housemate_1 = Housemate.new(housemates[0])
housemate_2 = Housemate.new(housemates[1])
housemate_3 = Housemate.new(housemates[2])
housemate_4 = Housemate.new(housemates[3])
housemate_5 = Housemate.new(housemates[4])

room_1 = Room.new(rooms[0], rooms_chores[rooms[0]])
room_2 = Room.new(rooms[1], rooms_chores[rooms[1]])
room_3 = Room.new(rooms[2], rooms_chores[rooms[2]])
room_4 = Room.new(rooms[3], rooms_chores[rooms[3]])
room_5 = Room.new(rooms[4], rooms_chores[rooms[4]])



if File.exist?("#{rota.rota_name}.db")
  puts "There is already rota with this name."
else
  db = SQLite3::Database.new("#{rota.rota_name}.db")

  rows = db.execute ("
    create table housemates(
      id int,
    housemate_name varchar(50),
    weeks_on_time int,
    weeks_late int,
    weeks_missed int
    );")

end

puts rows
rows.inspect
