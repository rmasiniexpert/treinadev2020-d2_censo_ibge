require 'spec_helper'

describe Censo do
  context 'messages' do

    it 'welcome' do
      censo = Censo.new
      expect{censo.messages.welcome}.to output(/Seja Bem-vindo ao Censo-IBGE/).to_stdout
    end

    it 'see query options' do
      censo = Censo.new
      allow(censo).to receive(:gets).and_return('4')

      expect{censo.start}.to output(/Selecione uma consulta/).to_stdout
    end
  end

  context 'select an option' do
    it 'option 1' do
      expect{Censo.new.messages.message_query_selected(1)}.to output(/Consulta de Ranking dos nomes mais comuns da UF/).to_stdout
    end

    it 'option 2' do
      expect{Censo.new.messages.message_query_selected(2)}.to output(/Consulta de Ranking dos nomes mais comuns da cidade/).to_stdout
    end

    it 'option 3' do
      expect{Censo.new.messages.message_query_selected(3)}.to output(/Frequência do uso do nome ao longo dos anos/).to_stdout
    end

    it 'option 4' do
      expect{Censo.new.query(4)}.to output(/Obrigado por utilizar a aplicação. Até a próxima/).to_stdout
    end

    it 'an invalid option' do
      expect{Censo.new.query(7)}.to output(/Valor inválido, digite apena um número da tabela/).to_stdout
    end

    it 'an invalid option and option 0' do
      allow_any_instance_of(Censo).to receive(:gets).and_return('7','4')
      censo = Censo.new

      expect{censo.start}.to output(/1- Nomes comuns por UF/).to_stdout
      expect{censo.start}.to output(/2- Nomes comuns por cidade/).to_stdout
      expect{censo.start}.to output(/3- frequência do uso do nome/).to_stdout
      expect{censo.start}.to output(/4- sair/).to_stdout
      expect{censo.start}.to output(/Digite um número: /).to_stdout
      expect{censo.start}.to output(/Obrigado por utilizar a aplicação. Até a próxima/).to_stdout
    end
  end
end