require 'faraday'
require 'json'
require 'terminal-table'
class Uf

  def exibe(url)
    rows = []
    headings = []
    headings <<  ['UF', 'Nome do Estado']
    # headings <<  ['                     Selecione uma consulta                      ']
    response = Faraday.get(url)
    response_body = JSON.parse(response.body, symbolize_names: true)
    for i in response_body do
      rows << [i[:sigla], i[:nome]]
    end
    table = Terminal::Table.new(rows: rows, headings: headings)
    puts table
  end
end