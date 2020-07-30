require 'faraday'
require 'json'
require 'terminal-table'
class Uf

  def exibe(url)
    rows = []
    headings = []
    headings <<  ['UF', 'Nome do Estado']
    response = Faraday.get(url)
    response_body = JSON.parse(response.body, symbolize_names: true)
    response_body.each do |uf|
      rows << [uf[:sigla], uf[:nome]]
    end
    table = Terminal::Table.new(rows: rows, headings: headings)
    puts table
  end
end