require 'faraday'
require 'json'
require 'terminal-table'
class Nome

  def exibe(base, localidade)
    rows = []
    headings = []
    headings <<  ['Ranking', 'Nome', 'Frequência do nome']
    response = Faraday.get(base, {localidade: localidade})
    if response.status != 200
      puts 'UF não encontrado'
      return
    end
    response_body = JSON.parse(response.body, symbolize_names: true)
    for i in 0..9 do
      rows << [response_body[0][:res][i][:ranking],
              response_body[0][:res][i][:nome],
              response_body[0][:res][i][:frequencia]]
    end
    table = Terminal::Table.new(rows: rows, headings: headings)
    puts table
  end
end