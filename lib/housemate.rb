class Housemate

  attr_accessor :current_room, :weeks_on_time, :weeks_late, :weeks_missed

  def initialize(current_room)
    @current_room = current_room
    @weeks_on_time = 0
    @weeks_late = 0
    @weeks_missed = 0
  end

end
