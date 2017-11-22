# only works if there there are never three or more adjacent Norooms

housemates = ["Alice", "Bob", "Charlie", "David", "Ed"]
rooms = ["kitchen", "bathroom", "hall", "Noroom", "Noroom"]


loop do
  count = 0
  rooms.shuffle!
  puts rooms
  puts "------"
  rooms.each_index {|i| puts rooms[i] and count += 1 if rooms[i] == rooms[i - 1]}
  break if count > 0
end
