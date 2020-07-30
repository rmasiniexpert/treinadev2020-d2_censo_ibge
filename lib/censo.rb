require './lib/messages'
require './lib/uf'
class Censo
  attr_reader :messages, :uf
  attr_accessor :input

  def initialize(input: 0)
    @messages = Messages.new
    @uf = Uf.new
    @input = input
  end
  
  def start
    @messages.welcome
    loop do
      @messages.select_query
      print 'Digite um número: '
      @input = gets.to_i
      query(@input)
      if @input == 4
        break
      end
    end
  end

  def query(query)
    if query == 1
      @messages.message_query_selected(query)
      query_with_uf
    elsif query == 2
      @messages.message_query_selected(query)
    elsif query == 3
      @messages.message_query_selected(query)
    elsif query == 4
      puts "\n\nObrigado por utilizar a aplicação. Até a próxima\n\n"
    else
      puts "\n\nValor inválido, digite apena um número da tabela\n\n"
    end
  end

  def query_with_uf
    puts "Carregando..."
    @uf.exibe("https://servicodados.ibge.gov.br/api/v1/localidades/estados")
    # print "Digite a UF que deseja buscar os nomes comuns: "
    # gets.upcase.chomp
  end
end