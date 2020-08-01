require 'faraday'
require 'json'
require 'terminal-table'
class FrequencyNames

  def initialize
    @years = ['1930','1930-1940','1940-1950','1950-1960','1960-1970',
              '1970-1980','1980-1990','1990-2000','2000-2010']
  end

  def main(base, names)
    response = receive_frequences(base, names)
    show_frequences(response)
  end

  def receive_frequences(base, names)
    names = convert_names(names)
    uri = good_uri("#{base}#{names}")
    response = Faraday.get(uri)
    body = JSON.parse(response.body, symbolize_names: true)
    for i in 0..((body.count) -1) do
      for j in 0..((body[i][:res].count) -1) do 
        body[i][:res][j][:periodo] = body[i][:res][j][:periodo].gsub("[","")
        body[i][:res][j][:periodo] = body[i][:res][j][:periodo].gsub("]","")
        body[i][:res][j][:periodo] = body[i][:res][j][:periodo].gsub(",","-")
      end
    end
    body
  end

  def good_uri(uri)
    URI.parse(URI.encode(uri))
  end

  def show_frequences(body)
    rows = []
    row = []
    frequence = []
    frequences = []
    period = []
    periods = []
    headings = []
    header = []
    cont = 0
    header << ' '
    for i in 0..((body.count) -1) do
      header << body[i][:nome]
      cont = 0
      for j in 0..((@years.count)-1) do
        if @years[j] == body[i][:res][cont][:periodo]
          period << body[i][:res][cont][:periodo]
          frequence << body[i][:res][cont][:frequencia]
          cont += 1
        else
          period << @years[j]
          frequence << 0
        end
      end
      frequences << frequence
      frequence = []
      periods << period
      period = []
    end
    headings <<  header
    for i in 0..((@years.count)-1) do
      row = []
      row << @years[i] 
      for j in 0..((periods.count)-1) do
        row << frequences[j][i]
      end
      rows << row
    end
    table = Terminal::Table.new(title: 'Frequência de nome(s) nas décadas',
                                headings: headings, rows: rows)
    puts table
  end

  def convert_names(names)
    names = remove_diacritics(names)
    names = names.gsub(/\s+/, "")
    names = names.gsub(",", "|")
    names = names.downcase
  end

  def remove_diacritics(str)
    accents = {
      ['á','à','â','ä','ã'] => 'a',
      ['Ã','Ä','Â','À'] => 'A',
      ['é','è','ê','ë'] => 'e',
      ['Ë','É','È','Ê'] => 'E',
      ['í','ì','î','ï'] => 'i',
      ['Î','Ì'] => 'I',
      ['ó','ò','ô','ö','õ'] => 'o',
      ['Õ','Ö','Ô','Ò','Ó'] => 'O',
      ['ú','ù','û','ü'] => 'u',
      ['Ú','Û','Ù','Ü'] => 'U',
      ['ç'] => 'c', ['Ç'] => 'C',
      ['ñ'] => 'n', ['Ñ'] => 'N'
    }
    accents.each do |ac,rep|
      ac.each do |s|
        str = str.gsub(s, rep)
      end
    end
    str = str.gsub(/[ ]+/," ")
  end
end