require "Date"

class Housemate

  attr_accessor :name, :weeks_on_time, :weeks_late, :weeks_missed, :rooms, :start_date

  def initialize(name, rooms = [])
    @name = name
    @rooms = rooms
    @weeks_on_time = 0
    @weeks_late = 0
    @weeks_missed = 0
    @start_date = first_monday(Date.today)
  end

  def create_housemate_rota (rooms)

  end

  private

  def first_monday (date)
    while !date.monday?
      date = date - 1
    end
    date
  end

end
