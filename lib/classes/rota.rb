require_relative "housemate"
require_relative "room"
require "Date"

class Rota
  attr_reader :name, :start_date
  def initialize(name)
    @name = name
    @start_date = first_monday(Date.today)
  end

  private

  def first_monday (date)
    while !date.monday?
      date = date - 1
    end
    date
  end


end


# Weekly payment instance variable
