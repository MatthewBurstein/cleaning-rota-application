class Housemate

  attr_accessor :housemate_name, :weeks_on_time, :weeks_late, :weeks_missed, :first_room

  def initialize(name)
    @housemate_name = name
    @first_room = ""
    @weeks_on_time = 0
    @weeks_late = 0
    @weeks_missed = 0
  end



end
