require 'spec_helper'

describe Uf do
  let(:body) {[{"id": 11, "sigla": "RO", "nome": "Rondônia", "regiao": 
                 {"id": 1, "sigla": "N", "nome": "Norte"}
               },
               {"id": 53, "sigla": "DF", "nome": "Distrito Federal", "regiao": 
                 {"id": 5, "sigla": "CO", "nome": "Centro-Oeste"}
               }]}
  let(:base) {"https://servicodados.ibge.gov.br/api/v1/localidades/estados"}
  let(:headers) {{'Accept'=>'*/*',
                  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                  'User-Agent'=>'Faraday v1.0.1'}}

  it 'GET with successfully' do
    stub_request(:get, base).with(headers: headers).
         to_return(status: 200, body: body.to_json, headers: {})

    response = Faraday.get(base)
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 200
    expect(response_body[0][:sigla]).to include('RO')
    expect(response_body[1][:sigla]).to include('DF')
  end

  it 'Show the All Ufs' do
    stub_request(:get, base).with(headers: headers).
         to_return(status: 200, body: body.to_json, headers: {})
    uf = Uf.new
    response = Faraday.get(base)
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect{uf.show_ufs(response_body)}.to output(/Distrito Federal/).to_stdout
    expect{uf.show_ufs(response_body)}.to output(/DF/).to_stdout
    expect{uf.show_ufs(response_body)}.to output(/Rondônia/).to_stdout
    expect{uf.show_ufs(response_body)}.to output(/RO/).to_stdout
  end

  it 'Input UF correctly' do
    allow_any_instance_of(Uf).to receive(:gets).and_return('RO')
    stub_request(:get, base).with(headers: headers).
         to_return(status: 200, body: body.to_json, headers: {})

    uf = Uf.new
    response = Faraday.get(base)
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(uf.select_Uf(response_body)[1]).to eq (11)
    expect(uf.select_Uf(response_body)[0]).to eq ('RO')
    expect{uf.select_Uf(response_body)[1]}.to output(/Digite a UF que deseja buscar os nomes comuns: /).to_stdout
    expect(uf.select_Uf(response_body)[1]).not_to eq (53)
    expect(uf.select_Uf(response_body)[0]).not_to eq ('DF')

  end

end
