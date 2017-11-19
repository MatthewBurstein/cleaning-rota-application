class ViewRotaWizard
  attr_accessor :rota

  def initialize(rota)
    @rota = rota
    puts "what would you like to do?"
  end

  def what_to_do
  end

  def get_housemates
  end

  def get_rooms
  end

  def view_current_week
  end

  def edit_housemates
  end

  def edit_rooms
  end

end

=begin
general_rotas_directory = "/Users/matt/Coding/Cleaning Rota App/rotas"

puts """
What is the name of the rota you would like to view?
"""

rota_name = gets.chomp

puts Dir.exist?("#{general_rotas_directory}/rotas/#{rota_name}")
=end
