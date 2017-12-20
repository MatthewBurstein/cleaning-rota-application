require "date"

class Date

  def next_monday
    date = Date.today
    while !date.monday?
      date += 1
    end
    date
  end

end

class String

  def custom_to_a
    self.split(";").each do |person|
      person.strip!
    end
  end

end
