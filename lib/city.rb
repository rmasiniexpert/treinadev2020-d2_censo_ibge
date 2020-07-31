require 'faraday'
require 'json'
require 'terminal-table'
class City

  def select_city_id(url, local)
    city_id = []
    response = Faraday.get("#{url}/#{local}/municipios")
    response_body = JSON.parse(response.body, symbolize_names: true)
    table = show_cities(response_body)
    loop do
      city_id = select_city(response_body)
      unless city_id[2].nil?
        break
      end
      puts "\n=================================================="
      puts "\n\nValor inválido, digite uma opção da tabela\n\n"
      puts table
    end
    puts "\n==================================================\n"
    puts "\n\nBuscando Tabelas de ranking dos nomes comuns em #{city_id[2]}"
    city_id[1]
  end

  def select_city(response_body)
    aux = []
    print "Digite o NÚMERO DA OPÇÃO da Cidade que deseja buscar os nomes comuns: "
    input = -1 + gets.to_i
    if input >= 0 && input < response_body.count
      aux << input
      aux << response_body[input][:id]
      aux << response_body[input][:nome]
    end
    aux
  end

  def show_cities(response_body)
    rows = []
    headings = []
    cont = 1
    headings <<  ['Opção', 'Nome da Cidade']
    response_body.each do |city|
      rows << [cont, city[:nome]]
      cont += 1
    end
    table = Terminal::Table.new(rows: rows, headings: headings)
    puts table
    table
  end
end