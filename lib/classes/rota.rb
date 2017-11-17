require_relative "housemate"
require_relative "room"

class Rota
  attr_reader :name
  def initialize(name)
    @name = name
  end

end


# Weekly payment instance variable
