require './lib/messages'
require './lib/uf'
require './lib/nome'
class Censo
  attr_reader :messages, :uf
  attr_accessor :input

  def initialize(input: 0)
    @messages = Messages.new
    @uf = Uf.new
    @nome = Nome.new
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
    @input = @uf.select_uf_id("https://servicodados.ibge.gov.br/api/v1/localidades/estados")
    @nome.exibe("https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking", @input)
  end
end