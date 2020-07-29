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
      puts 'Digite um número: '
      @input = gets.to_i

      if @input < 4 || @input >= 0 
        consult(@input)
        break
      end
    end
  end

  def consult(consult)
    if consult == 1
      puts 'Consulta de Ranking dos nomes mais comuns da UF'
    elsif consult == 2
      puts 'Consulta de Ranking dos nomes mais comuns da cidade'
    elsif consult == 3
      puts 'Frequência do uso do nome ao longo dos anos'
    elsif consult == 0
      puts 'Tchau'
    else
      puts 'Valor inválido, digite apena um número da tabela'
    end
  end
end