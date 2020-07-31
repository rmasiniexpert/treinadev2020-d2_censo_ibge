require 'faraday'
require 'json'
require 'terminal-table'
class Uf

  def select_uf_id(url)
    uf_id = []
    response = Faraday.get(url)
    response_body = JSON.parse(response.body, symbolize_names: true)
    table = show_ufs(response_body)
    loop do
      uf_id = select_Uf(response_body)
      unless uf_id[1].nil?
        break
      end
      puts "\n=============================================="
      puts "\n\nValor inválido, digite uma UF da tabela\n\n"
      puts table
    end
    puts "\n\nTabela do Ranking dos nomes comuns em #{uf_id[0]}\n\n"
    uf_id[1]
  end

  def show_ufs(response_body)
    rows = []
    headings = []
    headings <<  ['UF', 'Nome do Estado']
    response_body.each do |uf|
      rows << [uf[:sigla], uf[:nome]]
    end
    table = Terminal::Table.new(rows: rows, headings: headings)
    puts table
    table
  end

  def select_Uf(response_body)
    aux = []
    print "Digite a UF que deseja buscar os nomes comuns: "
    input = gets.upcase.chomp
    response_body.each do |uf|
      if uf[:sigla] == input
        aux << input
        aux << uf[:id]
      end
    end
    aux
  end
end