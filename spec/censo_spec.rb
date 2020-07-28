require 'spec_helper'
require 'stringio'

describe Censo do
  it 'aa' do
    # censo = welcome_with_input('Joao')
    censo = Censo.new
    expect{censo.messages.welcome}.to output(\
      "-------------------------------------------------------\n"\
      "              Seja Bem-vindo ao CensoRuby              \n"\
      "-------------------------------------------------------\n").to_stdout
    expect{censo.start}.to output(/Selecione qual consulta você quer fazer:/).to_stdout
    # expect{censo.start}.to include("Selecione qual consulta você quer fazer:").to_stdout_from_any_process
  end
end