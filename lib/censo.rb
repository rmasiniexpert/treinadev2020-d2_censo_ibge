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
    loop do
      @messages.select_consult
      print 'Digite um número: '
      @input = gets.to_i

      consult(@input)
      if @input < 4 && @input >= 0 
        break
      end
    end
  end

  def consult(consult)
    if consult == 1
      puts "\n\nConsulta de Ranking dos nomes mais comuns da UF\n\n"
    elsif consult == 2
      puts "\n\nConsulta de Ranking dos nomes mais comuns da cidade\n\n"
    elsif consult == 3
      puts "\n\nFrequência do uso do nome ao longo dos anos\n\n"
    elsif consult == 0
      puts "\n\nObrigado por utilizar a aplicação. Até a próxima\n\n"
    else
      puts "\n\nValor inválido, digite apena um número da tabela\n\n"
    end
  end
end