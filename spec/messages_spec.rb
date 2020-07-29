require 'spec_helper'

describe Messages do
  it 'welcome messages' do
    messages = Messages.new
    expect{messages.welcome}.to output(/Seja Bem-vindo ao Censo-IBGE/)
                                        .to_stdout
  end

  it 'see consult options' do
    messages = Messages.new

    expect{messages.select_consult}.to output(/1- Nomes comuns por UF/).to_stdout
    expect{messages.select_consult}.to output(/2- Nomes comuns por cidade/).to_stdout
    expect{messages.select_consult}.to output(/3- frequência do uso do nome/).to_stdout
    expect{messages.select_consult}.to output(/0- sair/).to_stdout
  end
end
