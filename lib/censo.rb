require 'messages'
class Censo
  attr_reader :messages
  def initialize
    @messages = Messages.new
    # @output = output
  end
  
  def start
    # input = @input.gets
    # puts "Bem-vindo a aplicação"
    # puts "Ola"
    @messages.welcome
    # puts ''
    puts 'Selecione qual consulta você quer fazer:'
    # a = gets
  end

# puts 'digite 2 valores'
# a = gets 
# b = gets
# puts "O resultado eh: #{a.to_i + b.to_i}"
end