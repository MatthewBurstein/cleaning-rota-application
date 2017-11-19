require_relative "create_rota_wizard"
# require_relative "view_rota_wizard.rb"
=begin
puts "What would you like to do? Create a new rota (c) or view/update an existing rota (v)"

input = gets.chomp.downcase

if input == "c"
  CreateRotaWizard.new.create_rota_wizard
elsif input == "v"
  puts "I haven't made this yet"
else
  puts "invalid input"
end
=end
