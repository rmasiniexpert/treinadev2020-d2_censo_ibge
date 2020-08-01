require 'spec_helper'

describe FrequencyNames do
  let(:body) {[{ "nome": "JOAO", "sexo": "null", "localidade": "BR", "res":
              [ { "periodo": "1930[", "frequencia": 60155 },
                { "periodo": "[1930,1940[", "frequencia": 141772 },
                {"periodo": "[1940,1950[","frequencia": 256001 },
                {"periodo": "[1950,1960[","frequencia": 396438 },
                {"periodo": "[1960,1970[","frequencia": 429148 },
                {"periodo": "[1970,1980[","frequencia": 279975 },
                {"periodo": "[1980,1990[","frequencia": 273960 },
                {"periodo": "[1990,2000[","frequencia": 352552 },
                {"periodo": "[2000,2010[","frequencia": 794118 }
              ]
             }]}
  let(:body2) {[{ "nome": "JOAO", "sexo": "null", "localidade": "BR", "res": 
                [ {"periodo": "1930[","frequencia": 60155 },
                  {"periodo": "[1930,1940[","frequencia": 141772 },
                  {"periodo": "[1940,1950[","frequencia": 256001 },
                  {"periodo": "[1950,1960[","frequencia": 396438 },
                  {"periodo": "[1960,1970[","frequencia": 429148 },
                  {"periodo": "[1970,1980[","frequencia": 279975 },
                  {"periodo": "[1980,1990[","frequencia": 273960 },
                  {"periodo": "[1990,2000[","frequencia": 352552 },
                  {"periodo": "[2000,2010[","frequencia": 794118 }
                ]},
              { "nome": "MARIA","sexo": "null","localidade": "BR","res": 
                [ {"periodo": "1930[","frequencia": 336477},
                  {"periodo": "[1930,1940[","frequencia": 749053},
                  {"periodo": "[1940,1950[","frequencia": 1487042},
                  {"periodo": "[1950,1960[","frequencia": 2476482},
                  {"periodo": "[1960,1970[","frequencia": 2495491},
                  {"periodo": "[1970,1980[","frequencia": 1616019},
                  {"periodo": "[1980,1990[","frequencia": 917968},
                  {"periodo": "[1990,2000[","frequencia": 544296},
                  {"periodo": "[2000,2010[","frequencia": 1111301}
                ]
              }]}
  let(:body3) {[{"nome": "GABRIEL","sexo": "null","localidade": "BR","res": 
                [ {"periodo": "1930[","frequencia": 1267},
                  {"periodo": "[1930,1940[","frequencia": 2744},
                  {"periodo": "[1940,1950[","frequencia": 4256},
                  {"periodo": "[1950,1960[","frequencia": 6095},
                  {"periodo": "[1960,1970[","frequencia": 6559},
                  {"periodo": "[1970,1980[","frequencia": 9103},
                  {"periodo": "[1980,1990[","frequencia": 46996},
                  {"periodo": "[1990,2000[","frequencia": 271405},
                  {"periodo": "[2000,2010[","frequencia": 584024}
                ]},
              { "nome": "JOAO", "sexo": "null", "localidade": "BR", "res": 
                [ {"periodo": "1930[","frequencia": 60155},
                  {"periodo": "[1930,1940[","frequencia": 141772},
                  {"periodo": "[1940,1950[","frequencia": 256001},
                  {"periodo": "[1950,1960[","frequencia": 396438},
                  {"periodo": "[1960,1970[","frequencia": 429148},
                  {"periodo": "[1970,1980[","frequencia": 279975},
                  {"periodo": "[1980,1990[","frequencia": 273960},
                  {"periodo": "[1990,2000[","frequencia": 352552},
                  {"periodo": "[2000,2010[","frequencia": 794118}
                ]},
              {"nome": "MARIA","sexo": "null","localidade": "BR","res": 
                [ {"periodo": "1930[","frequencia": 336477},
                  {"periodo": "[1930,1940[","frequencia": 749053},
                  {"periodo": "[1940,1950[","frequencia": 1487042},
                  {"periodo": "[1950,1960[","frequencia": 2476482},
                  {"periodo": "[1960,1970[","frequencia": 2495491},
                  {"periodo": "[1970,1980[","frequencia": 1616019},
                  {"periodo": "[1980,1990[","frequencia": 917968},
                  {"periodo": "[1990,2000[","frequencia": 544296},
                  {"periodo": "[2000,2010[","frequencia": 1111301}
                ]}
              ]}

  let(:base) {"https://servicodados.ibge.gov.br/api/v2/censos/nomes/"}
  let(:headers) {{'Accept'=>'*/*',
                  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                  'User-Agent'=>'Faraday v1.0.1'}}

  context 'treat names' do
    it 'receive one name' do
      stub_request(:get, "#{base}joao").with(headers: headers).
      to_return(status: 200, body: body.to_json, headers: {})
      
      expect(FrequencyNames.new.convert_names('joao')).to eq 'joao'
    end
      
    it 'receive one name with space' do
      stub_request(:get, "#{base}joao").with(headers: headers).
      to_return(status: 200, body: body.to_json, headers: {})

      expect(FrequencyNames.new.convert_names(' joao ')).to eq 'joao'
    end
    
    it 'receive two names with comma' do
      stub_request(:get, "#{base}joao").with(headers: headers).
      to_return(status: 200, body: body.to_json, headers: {})
      
      converte = FrequencyNames.new.convert_names('joao,maria')
      expect(converte).to eq('joao|maria')
    end
    
    it 'receive two names with comma and space' do
      stub_request(:get, "#{base}joao").with(headers: headers).
      to_return(status: 200, body: body.to_json, headers: {})

      converte = FrequencyNames.new.convert_names(' joao , maria ')
      expect(converte).to eq('joao|maria')
    end
    
    it 'receive three names with comma and space' do
      stub_request(:get, "#{base}joao").with(headers: headers).
          to_return(status: 200, body: body.to_json, headers: {})

      converte = FrequencyNames.new.convert_names(' joao , maria, guilherme ')

      expect(converte).to eq('joao|maria|guilherme')
    end
    
    it 'receive three names with comma and accents' do
      stub_request(:get, "#{base}joao").with(headers: headers).
      to_return(status: 200, body: body.to_json, headers: {})

      converte = FrequencyNames.new.convert_names('joão,Júlia,Antônio')
      
      expect(converte).to eq('joao|julia|antonio')
    end
  end
  
  it 'receive one name' do
    stub_request(:get, "#{base}joao").with(headers: headers).
    to_return(status: 200, body: body.to_json, headers: {})
    
    freq = FrequencyNames.new.receive_frequences(base, 'joao')
    
    expect(freq[0][:res][0][:periodo]).to eq '1930'
    expect(freq[0][:res][0][:frequencia]).to eq 60155
    expect(freq[0][:res][-1][:periodo]).to eq '2000-2010'
    expect(freq[0][:res][-1][:frequencia]).to eq 794118
  end

  it 'receive two names' do
    stub_request(:get, "#{base}joao%7Cmaria").with(headers: headers).
    to_return(status: 200, body: body2.to_json, headers: {})

    freq = FrequencyNames.new.receive_frequences(base, 'joao,maria')
    
    expect(freq[0][:res][0][:periodo]).to eq '1930'
    expect(freq[0][:res][0][:frequencia]).to eq 60155
    expect(freq[0][:res][-1][:periodo]).to eq '2000-2010'
    expect(freq[0][:res][-1][:frequencia]).to eq 794118
    expect(freq[1][:res][0][:periodo]).to eq '1930'
    expect(freq[1][:res][0][:frequencia]).to eq 336477
    expect(freq[1][:res][-1][:periodo]).to eq '2000-2010'
    expect(freq[1][:res][-1][:frequencia]).to eq 1111301
  end

  it 'receive three names' do
    stub_request(:get, "#{base}gabriel%7Cmaria%7Cjoao").with(headers: headers).
    to_return(status: 200, body: body3.to_json, headers: {})
    
    freq = FrequencyNames.new.receive_frequences(base, ' gábriel ,maria,joao')

    expect(freq[0][:nome]).to eq 'GABRIEL'
    expect(freq[0][:res][0][:periodo]).to eq '1930'
    expect(freq[0][:res][0][:frequencia]).to eq 1267
    expect(freq[0][:res][-1][:periodo]).to eq '2000-2010'
    expect(freq[0][:res][-1][:frequencia]).to eq 584024
    expect(freq[1][:nome]).to eq 'JOAO'
    expect(freq[1][:res][0][:periodo]).to eq '1930'
    expect(freq[1][:res][0][:frequencia]).to eq 60155
    expect(freq[1][:res][-1][:periodo]).to eq '2000-2010'
    expect(freq[1][:res][-1][:frequencia]).to eq 794118
    expect(freq[2][:nome]).to eq 'MARIA'
    expect(freq[2][:res][0][:periodo]).to eq '1930'
    expect(freq[2][:res][0][:frequencia]).to eq 336477
    expect(freq[2][:res][-1][:periodo]).to eq '2000-2010'
    expect(freq[2][:res][-1][:frequencia]).to eq 1111301
  end
end