require 'faraday'
require 'json'
require 'terminal-table'
class Name

  def initialize 
    @base = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking"
  end

  def show(base: @base, local: nil, gender: nil)
    if local.nil?
      url = base
    elsif gender.nil?
      url = "#{base}?localidade=#{local}#{}"
    else
      url = "#{base}?localidade=#{local}&sexo=#{gender}"
    end
    rows = []
    headings = []
    headings <<  ['Ranking', 'Nome', 'Frequência do nome']
    response = Faraday.get(url)
    response_body = JSON.parse(response.body, symbolize_names: true)
    response_body[0][:res].each do |uf|
      rows << [uf[:ranking],
              uf[:nome],
              uf[:frequencia]]
    end
    table = Terminal::Table.new(rows: rows, headings: headings)
    puts table
  end

end