require_relative "housemate"
require_relative "room"
require "Date"

class Rota
  attr_accessor :name, :start_date, :length, :directory
  def initialize(name, length = 0)
    @name = name
    @start_date = first_monday(Date.today)
    @length = length #in weeks
    @directory = ""
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
