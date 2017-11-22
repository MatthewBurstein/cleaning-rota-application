=begin
require_relative "class_create_rota_wizard"
require_relative "view_rota_wizard.rb"

puts "What would you like to do? Create a new rota (c) or view/update an existing rota (v)"

input = gets.chomp.downcase

if input == "c"
  CreateRotaWizard.new
elsif input == "v"
  puts "I haven't made this yet"
else
  puts "invalid input"
end
=end

class RunMe
  def initialize
  end

  def tester
    return "I'm a test"
  end
end
