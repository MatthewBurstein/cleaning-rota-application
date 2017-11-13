require_relative "housemate"
require_relative "room"

class Rota
  attr_reader :rota_name
  def initialize(rota_name)
    @rota_name = rota_name
  end

end


# Weekly payment instance variable
