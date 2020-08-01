require 'faraday'
require 'json'
require 'terminal-table'
class Uf

  def initialize
    @body = 0
    @input = []
  end

  def select_uf_id(irl)
    @input = []
    response = Faraday.get(irl)
    @body = JSON.parse(response.body, symbolize_names: true)
    table = show_ufs(@body)
    message_input(@body)
    
    # @input[1]
  end

  def show_ufs(body)
    rows = []
    headings = []
    headings <<  ['UF', 'Nome do Estado']
    body.each do |uf|
      rows << [uf[:sigla], uf[:nome]]
    end
    table = Terminal::Table.new(title: 'Unidade da Federação do Brasil',
                                rows: rows, headings: headings)
    puts table
    table
  end

  def message_input(body)
    loop do
      print "Digite a UF que deseja buscar os nomes comuns: "
      @input = select_uf(body)
      unless @input[1].nil?
        break
      end
      puts "\n=================================================="
      puts "\n\nValor inválido, digite uma UF da tabela\n\n"
      puts table
    end
    puts "\n==================================================\n"
    puts "\n\nBuscando Tabelas de ranking dos nomes comuns em #{@input[0]}"
    # select_uf()
    @input[1]
  end

  def select_uf(body)
    aux = []
    input = gets.upcase.chomp
    body.each do |uf|
      if uf[:sigla] == input
        aux << input
        aux << uf[:id]
      end
    end
    aux
  end
end