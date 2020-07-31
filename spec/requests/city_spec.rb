require 'spec_helper'

describe City do
  let(:body_sp) {[{"id": 3500105, "nome": "Adamantina" },
                  {"id": 3500204, "nome": "Adolfo" },
                  {"id": 3500303,  "nome": "Aguaí"},
                  {"id": 3500402, "nome": "Águas da Prata"  }
                ]}
  let(:body) {[{"id": 3500501,"nome": "Águas de Lindóia", },
               {"id": 3500550,"nome": "Águas de Santa Bárbara", },
               {"id": 3500600,"nome": "Águas de São Pedro",},
              ]}
  let(:base) {"https://servicodados.ibge.gov.br/api/v1/localidades/estados"}
  let(:headers) {{'Accept'=>'*/*',
                  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                  'User-Agent'=>'Faraday v1.0.1'}}
  it 'GET with successfully body_sp' do
    stub_request(:get, "#{base}/35/municipios").with(headers: headers).
        to_return(status: 200, body: body_sp.to_json, headers: {})

    response = Faraday.get("#{base}/35/municipios")
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq 200

    expect(response_body[0][:nome]).to eq("Adamantina")
    expect(response_body[0][:id]).to eq(3500105)
    expect(response_body[0][:id]).not_to eq(3500501)
    expect(response_body[0][:nome]).not_to eq("Águas de Lindóia")
  end

  it 'GET with successfully body' do
    stub_request(:get, "#{base}/35/municipios").with(headers: headers).
        to_return(status: 200, body: body.to_json, headers: {})

    response = Faraday.get("#{base}/35/municipios")
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq 200

    expect(response_body[0][:id]).to eq(3500501)
    expect(response_body[0][:nome]).to eq("Águas de Lindóia")
    expect(response_body[0][:nome]).not_to eq("Adamantina")
    expect(response_body[0][:id]).not_to eq(3500105)
  end

  it 'Show all the cities' do
    stub_request(:get, "#{base}/35/municipios").with(headers: headers).
        to_return(status: 200, body: body_sp.to_json, headers: {})

    response = Faraday.get("#{base}/35/municipios")
    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq 200

    expect{City.new.show_cities(response_body)}.to output(/Adamantina/).to_stdout
    expect{City.new.show_cities(response_body)}.to output(/Adolfo/).to_stdout
    expect{City.new.show_cities(response_body)}.to output(/Aguaí/).to_stdout
    expect{City.new.show_cities(response_body)}.to output(/Águas da Prata/).to_stdout
  end

  it 'Input City correctly' do
    allow_any_instance_of(City).to receive(:gets).and_return(1)
    stub_request(:get, "#{base}/35/municipios").with(headers: headers).
         to_return(status: 200, body: body_sp.to_json, headers: {})

    city = City.new
    response = Faraday.get("#{base}/35/municipios")
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(city.select_city(response_body)[0]).to eq (0)
    expect(city.select_city(response_body)[1]).to eq (3500105)
    expect(city.select_city(response_body)[2]).to eq ('Adamantina')
    expect{city.select_city(response_body)[0]}.to output(/Digite o NÚMERO DA OPÇÃO da Cidade que deseja buscar os nomes comuns: /).to_stdout
    expect(city.select_city(response_body)[1]).not_to eq (3500204)
    expect(city.select_city(response_body)[1]).not_to eq (2)

  end

  it 'Receive city id' do
    allow_any_instance_of(City).to receive(:gets).and_return(1)
    stub_request(:get, "#{base}/35/municipios").with(headers: headers).
         to_return(status: 200, body: body_sp.to_json, headers: {})

    expect(City.new.select_city_id(base, 35)).to eq (3500105)
  end
end