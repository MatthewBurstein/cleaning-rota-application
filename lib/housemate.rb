require "Date"

class Housemate

  attr_accessor :housemate_name, :weeks_on_time, :weeks_late, :weeks_missed, :room_array, :start_date

  def initialize(name, room_array)
    @housemate_name = name
    @room_array = room_array
    @weeks_on_time = 0
    @weeks_late = 0
    @weeks_missed = 0
    @start_date = first_monday(Date.today)
  end

  def create_houesmate_rota (array_rooms)

  end

  private

  def first_monday (date)
    while !date.monday?
      date = date - 1
    end
    date
  end

end

matt = Housemate.new("Matt")

puts "#{matt.start_date}"
