require 'spec_helper'

describe Uf do
  let(:body) {[{"id": 11, "sigla": "RO", "nome": "Rondônia", "regiao": 
                 {"id": 1, "sigla": "N", "nome": "Norte"}
               },
               {"id": 53, "sigla": "DF", "nome": "Distrito Federal", "regiao": 
                 {"id": 5, "sigla": "CO", "nome": "Centro-Oeste"}
               }
              ]}
  xit 'GET with successfully' do
    stub_request(:get, "https://servicodados.ibge.gov.br/api/v1/localidades/estados").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.0.1'
           }).
         to_return(status: 200, body: body.to_json, headers: {})

    response = Faraday.get("https://servicodados.ibge.gov.br/api/v1/localidades/estados")
    response_body = JSON.parse(response.body, symbolize_names: true)

    # binding.pry
    expect(response.status).to eq 200
    expect(response_body[0][:sigla]).to include('RO')
    expect(response_body[1][:sigla]).to include('DF')
    expect(Uf.exibe).to include(/Distrito Federal/)
    expect(Uf.exibe).to include(/DF/)
    expect(Uf.exibe).to include(/Rondônia/)
    expect(Uf.exibe).to include(/RO/)

  end
end
