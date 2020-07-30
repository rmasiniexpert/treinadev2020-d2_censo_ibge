require 'terminal-table'
class Messages
  def initialize
    @table_welcome = set_table_welcome
    @table_queries = set_table_queries
  end
  
  def welcome
    puts @table_welcome
  end

  def select_query
    puts @table_queries
  end

  def message_query_selected(number)
    if number == 1
      puts "\n\nConsulta de Ranking dos nomes mais comuns da UF\n\n"
    elsif number == 2
      puts "\n\nConsulta de Ranking dos nomes mais comuns da cidade\n\n"
    elsif number == 3
      puts "\n\nFrequência do uso do nome ao longo dos anos\n\n"
    end
  end

  private 

  def set_table_welcome
    rows = []
    rows << ["                     "\
            "Seja Bem-vindo ao Censo-IBGE"\
            "                     "]
    table = Terminal::Table.new(rows: rows)
  end

  def set_table_queries
    rows = []
    headings = []
    headings <<  ['                     Selecione uma consulta                      ']
    rows << ["                     1- Nomes comuns por UF                           "]
    rows << ["                     2- Nomes comuns por cidade                       "]
    rows << ["                     3- frequência do uso do nome                     "]
    rows << ["                     4- sair                      "]
    table = Terminal::Table.new(rows: rows, headings: headings)
  end
end