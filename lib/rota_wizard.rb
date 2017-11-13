require_relative "rota"
require_relative "room"
require_relative "housemate"

puts """
  This wizard will help you create a cleaning rota for a shared house.

  First, choose a name for your rota:
"""

  input = gets.chomp
  rota = Rota.new("#{input}")

  puts "the rota name is #{rota}"

puts """
  Great! Now list the housemates living in the house. Names should be separated by semicolons.
"""

  housemates = gets.chomp.split(";").each do |person|
    person.strip!
  end

puts """
  Amazing! Now provide a list of the rooms which need cleaning, separated by semicolons.
"""

  rooms = gets.chomp.split(";").each do |room|
    room.strip!
  end

puts """
  Perfect! Now, for each room, please list 3 chores which need to be completed.
"""

  rooms_chores = {}
  rooms.each do |room|
    puts "Chores for #{room} separated by semicolons:"

    rooms_chores["#{room}"] = gets.chomp.split(";").each do |chore|
                  chore.strip!
                end
    end

puts """
  Great! Now that's done. I'll set create the rota, assigning each housemate to a room for each week starting from this week.
"""

=begin
  rooms.each do |room|
    puts "chores for #{room} separated by semicolons:"
    instance_variable_set("@#{room}_chores", gets.chomp.split(";").each do |chore|
              chore.strip!
            end)
  end


=begin
if File.exist?("#{rota_name}.db")
  puts "There is already rota with this name."
else
  File.new("#{rota_name}.db", "w+")
end
=end
