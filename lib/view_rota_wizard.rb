require "CSV"

class ViewRotaWizard
  attr_accessor :rota
  attr_reader :directory

  def initialize(rota)
    @rota = rota
    @directory = "/Users/matt/Coding/Cleaning Rota App/rotas"
    puts "what would you like to do?"
  end

  def open_rota_csv
    housemates = CSV.read("#{@directory}/#{@rota}/#{@rota}_rota.csv", return_headers:false)
    rota_headers = housemates.shift
    puts "housemates is #{housemates}"
    puts "rota_headers is #{rota_headers}"
  end

  def open_rooms_csv
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

rota = ViewRotaWizard.new("MyRota")
rota.open_rota_csv



=begin
general_rotas_directory = "/Users/matt/Coding/Cleaning Rota App/rotas"

puts """
What is the name of the rota you would like to view?
"""

rota_name = gets.chomp

puts Dir.exist?("#{general_rotas_directory}/rotas/#{rota_name}")
=end
