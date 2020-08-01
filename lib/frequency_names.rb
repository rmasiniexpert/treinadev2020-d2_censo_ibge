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
    response_body = JSON.parse(response.body, symbolize_names: true)
    for i in 0..((response_body.count) -1) do
      for j in 0..((response_body[i][:res].count) -1) do 
        response_body[i][:res][j][:periodo] = response_body[i][:res][j][:periodo].gsub("[","")
        response_body[i][:res][j][:periodo] = response_body[i][:res][j][:periodo].gsub("]","")
        response_body[i][:res][j][:periodo] = response_body[i][:res][j][:periodo].gsub(",","-")
      end
    end
    response_body
  end

  def good_uri(uri)
    URI.parse(URI.encode(uri))
  end

  def show_frequences(response_body)
    rows = []
    row = []
    frequence = []
    frequences = []
    period = []
    periods = []
    headings = []
    header = []
    cont = 0
    header << 'Freq. por decada'
    for i in 0..((response_body.count) -1) do
      header << response_body[i][:nome]
      cont = 0
      for j in 0..((@years.count)-1) do
        if @years[j] == response_body[i][:res][cont][:periodo]
          period << response_body[i][:res][cont][:periodo]
          frequence << response_body[i][:res][cont][:frequencia]
          cont += 1
        else
          period << @years[j]
          frequence << 0
        end
      end
    # end
      # for j in 0..((response_body[i][:res].count) -1) do 
      #   period << response_body[i][:res][j][:periodo]
      #   frequence << response_body[i][:res][j][:frequencia]
      # end
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
        # for k in 0..((periods[j].count)-1) do
        #   if @years[i] == periods[j][k]
        #     row << frequences[j][k]
        #   # else
        #   #   row << 0
        #   end
        # end
      end
      rows << row

    end
    table = Terminal::Table.new(rows: rows, headings: headings)
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