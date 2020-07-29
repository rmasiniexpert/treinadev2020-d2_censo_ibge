require 'spec_helper'
# require 'stringio'

describe Censo do
  it 'welcome messages' do
    censo = Censo.new
    expect{censo.messages.welcome}.to output(/Seja Bem-vindo ao Censo-IBGE/)
                                        .to_stdout
  end

  it 'see consult options' do
    censo = Censo.new
    allow(censo).to receive(:gets).and_return('0')

    expect{censo.start}.to output(/Selecione uma consulta/).to_stdout
  end

  it 'select option 1' do
    allow_any_instance_of(Censo).to receive(:gets).and_return("1")
    censo = Censo.new

    expect{censo.start}.to output(/1- Nomes comuns por UF/).to_stdout
    expect{censo.start}.to output(/2- Nomes comuns por cidade/).to_stdout
    expect{censo.start}.to output(/3- frequência do uso do nome/).to_stdout
    expect{censo.start}.to output(/0- sair/).to_stdout
    expect{censo.start}.to output(/Digite um número: /).to_stdout
    expect{censo.start}.to output(/Consulta de Ranking dos nomes mais comuns da UF/).to_stdout
  end

  it 'select option 2' do
    allow_any_instance_of(Censo).to receive(:gets).and_return('2')
    censo = Censo.new

    expect{censo.start}.to output(/1- Nomes comuns por UF/).to_stdout
    expect{censo.start}.to output(/2- Nomes comuns por cidade/).to_stdout
    expect{censo.start}.to output(/3- frequência do uso do nome/).to_stdout
    expect{censo.start}.to output(/0- sair/).to_stdout
    expect{censo.start}.to output(/Digite um número: /).to_stdout
    expect{censo.start}.to output(/Consulta de Ranking dos nomes mais comuns da cidade/).to_stdout
  end

  it 'select option 3' do
    allow_any_instance_of(Censo).to receive(:gets).and_return('3')
    censo = Censo.new

    expect{censo.start}.to output(/1- Nomes comuns por UF/).to_stdout
    expect{censo.start}.to output(/2- Nomes comuns por cidade/).to_stdout
    expect{censo.start}.to output(/3- frequência do uso do nome/).to_stdout
    expect{censo.start}.to output(/0- sair/).to_stdout
    expect{censo.start}.to output(/Digite um número: /).to_stdout
    expect{censo.start}.to output(/Frequência do uso do nome ao longo dos anos/).to_stdout
  end

  it 'select option 0' do
    allow_any_instance_of(Censo).to receive(:gets).and_return('0')
    censo = Censo.new

    expect{censo.start}.to output(/1- Nomes comuns por UF/).to_stdout
    expect{censo.start}.to output(/2- Nomes comuns por cidade/).to_stdout
    expect{censo.start}.to output(/3- frequência do uso do nome/).to_stdout
    expect{censo.start}.to output(/0- sair/).to_stdout
    expect{censo.start}.to output(/Digite um número: /).to_stdout
    expect{censo.start}.to output(/Obrigado por utilizar a aplicação. Até a próxima/).to_stdout
  end

  it 'select an invalid option' do
    # allow_any_instance_of(Censo).to receive(:gets).and_return('7')
    allow_any_instance_of(Censo).to receive(:gets).and_return('7','0')
    censo = Censo.new

    expect{censo.start}.to output(/1- Nomes comuns por UF/).to_stdout
    expect{censo.start}.to output(/2- Nomes comuns por cidade/).to_stdout
    expect{censo.start}.to output(/3- frequência do uso do nome/).to_stdout
    expect{censo.start}.to output(/0- sair/).to_stdout
    expect{censo.start}.to output(/Digite um número: /).to_stdout
    # expect{censo.start}.to output(/Valor inválido, digite apena um número da tabela/).to_stdout
  end

  it 'select an invalid option and option 1' do
    allow_any_instance_of(Censo).to receive(:gets).and_return('7','1')
    censo = Censo.new

    expect{censo.start}.to output(/1- Nomes comuns por UF/).to_stdout
    expect{censo.start}.to output(/2- Nomes comuns por cidade/).to_stdout
    expect{censo.start}.to output(/3- frequência do uso do nome/).to_stdout
    expect{censo.start}.to output(/0- sair/).to_stdout
    expect{censo.start}.to output(/Digite um número: /).to_stdout
    expect{censo.start}.to output(/Consulta de Ranking dos nomes mais comuns da UF/).to_stdout
  end
end