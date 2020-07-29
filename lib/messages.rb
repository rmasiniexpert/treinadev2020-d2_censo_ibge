require 'terminal-table'
class Messages
  def initialize
    @table_welcome = set_table_welcome
    @table_consults = set_table_consults
  end
  
  def welcome
    puts @table_welcome
  end

  def select_consult
    puts @table_consults
  end

  private 

  def set_table_welcome
    rows = []
    rows << ["                     "\
            "Seja Bem-vindo ao Censo-IBGE"\
            "                     "]
    table = Terminal::Table.new(rows: rows)
  end

  def set_table_consults
    rows = []
    headings = []
    headings <<  ['                     Selecione uma consulta                      ']
    rows << ["                     1- Nomes comuns por UF                           "]
    rows << ["                     2- Nomes comuns por cidade                       "]
    rows << ["                     3- frequência do uso do nome                     "]
    rows << ["                     0- sair                      "]
    table = Terminal::Table.new(rows: rows, headings: headings)
  end
end