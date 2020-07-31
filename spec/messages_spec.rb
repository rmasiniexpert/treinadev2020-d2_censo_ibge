require 'spec_helper'

describe Messages do
  it 'welcome messages' do
    messages = Messages.new
    expect{messages.welcome}.to output(/Seja Bem-vindo ao Censo-IBGE/)
                                        .to_stdout
  end

  it 'see query options' do
    messages = Messages.new

    expect{messages.select_query}.to output(/1- Nomes comuns por UF/).to_stdout
    expect{messages.select_query}.to output(/2- Nomes comuns por cidade/).to_stdout
    expect{messages.select_query}.to output(/3- Frequência do uso do nome/).to_stdout
    expect{messages.select_query}.to output(/4- Sair/).to_stdout
  end

  context 'query selected message' do
    it 'query 1' do
      expect{Messages.new.message_query_selected(1)}.to output(/Consulta de Ranking dos nomes mais comuns da UF/).to_stdout
      expect{Messages.new.message_query_selected(1)}.not_to output(/Consulta de Ranking dos nomes mais comuns da cidade/).to_stdout
      expect{Messages.new.message_query_selected(1)}.not_to output(/Frequência do uso do nome ao longo dos anos/).to_stdout
      end
    
    it 'query 2' do
      expect{Messages.new.message_query_selected(2)}.to output(/Consulta de Ranking dos nomes mais comuns da cidade/).to_stdout
      expect{Messages.new.message_query_selected(2)}.not_to output(/Consulta de Ranking dos nomes mais comuns da UF/).to_stdout
      expect{Messages.new.message_query_selected(2)}.not_to output(/Frequência do uso do nome ao longo dos anos/).to_stdout
    end
    
    it 'query 3' do
      expect{Messages.new.message_query_selected(3)}.to output(/Frequência do uso do nome ao longo dos anos/).to_stdout
      expect{Messages.new.message_query_selected(3)}.not_to output(/Consulta de Ranking dos nomes mais comuns da UF/).to_stdout
      expect{Messages.new.message_query_selected(3)}.not_to output(/Consulta de Ranking dos nomes mais comuns da cidade/).to_stdout
    end
  end
end
