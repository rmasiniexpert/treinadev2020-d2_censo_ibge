require 'spec_helper'
# require 'stringio'

describe Censo do
  it 'welcome messages' do
    censo = Censo.new
    expect{censo.messages.welcome}.to output(/Seja Bem-vindo ao CensoRuby/)
                                        .to_stdout
  end

  it 'see consult options' do
    censo = Censo.new

    expect{censo.start}.to output(/Selecione uma consulta/).to_stdout
  end

  it 'select option 1' do
    censo = Censo.new(input: 1)

    expect{censo.start}.to output(/1- Nomes comuns por UF/).to_stdout
    expect{censo.start}.to output(/2- Nomes comuns por cidade/).to_stdout
    expect{censo.start}.to output(/3- frequência do uso do nome/).to_stdout
    expect{censo.start}.to output(/0- sair/).to_stdout
    expect(censo.input).to eq 1
    # expect{censo.start}.to output(/Consulta por nomes na UF/)
    #                          .to_stdout
  end
end