require "date"

class Date

  def next_monday
    date = self
    while !date.monday?
      date += 1
    end
    date
  end

end
