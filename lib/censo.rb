require './lib/messages'
class Censo
  attr_reader :messages
  attr_accessor :input

  def initialize(input: 0)
    @messages = Messages.new
    @input = input
  end
  
  def start
    @messages.welcome
    # puts ''
    loop do
      @messages.select_consult
      @input = gets.to_i

      if @input < 4 && @input >= 0 
        break
      begin
        puts
      rescue => exception
        
      else
        
      end
      end
    end
  end

# puts 'digite 2 valores'
# a = gets 
# b = gets
# puts "O resultado eh: #{a.to_i + b.to_i}"
end