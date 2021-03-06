
require_relative "create_rota_wizard"
require_relative "view_rota_wizard.rb"


class RunMe
  def initialize
    choice = ""
    loop do
      break if ["1", "2", "3"].include?(choice)
      puts "What would you like to do? \n\t
      1. Create a new rota\n\t
      2. View or update an existing rota\n\t
      3. Quit the program"
      choice = gets.chomp
      case choice
        when "1"
          CreateRotaWizard.new
        when "2"
          ViewRotaWizard.new.init_view_rota
        when "3"
          puts "Goodbye!"
          exit(true)
        else
          puts "That is not a valid input. Please choose again."
      end
    end
  end
end

RunMe.new
