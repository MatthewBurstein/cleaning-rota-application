require_relative "housemate"
require_relative "room"
require "Date"

class Rota
  attr_accessor :name, :start_date, :length
  def initialize(name, length)
    @name = name
    @start_date = first_monday(Date.today)
    @length = length
  end

  private

  def first_monday (date)
    while !date.monday?
      date = date + 1
    end
    date
  end


end


# Weekly payment instance variable
