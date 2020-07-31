require 'spec_helper'

describe Name do
  let(:body_df) {[{"localidade": "53", "sexo": "null", "res":
                [ {"nome": "MARIA", "frequencia": 146770, "ranking": 1},
                  {"nome": "JOSE", "frequencia": 53505, "ranking": 2 },
                  {"nome": "ANA", "frequencia": 49963, "ranking": 3 },
                  {"nome": "JOAO", "frequencia": 38398, "ranking": 4 },
                  {"nome": "ANTONIO",  "frequencia": 28739, "ranking": 5 },
                  {"nome": "FRANCISCO", "frequencia": 25426, "ranking": 6 },
                  {"nome": "PEDRO", "frequencia": 21347, "ranking": 7 },
                  {"nome": "CARLOS", "frequencia": 20310, "ranking": 8 },
                  {"nome": "PAULO", "frequencia": 19379, "ranking": 9 },
                  {"nome": "LUCAS", "frequencia": 19258, "ranking": 10 },
                ]}]}
  let(:body_f) {[{"localidade": "53", "sexo": "null", "res":
                [ {"nome": "MARIA", "frequencia": 146770, "ranking": 1},
                  {"nome": "ANA", "frequencia": 49963, "ranking": 3 },
                ]}]}
  let(:body_m) {[{"localidade": "53", "sexo": "null", "res":
                [ {"nome": "JOSE", "frequencia": 53505, "ranking": 2 },
                  {"nome": "JOAO", "frequencia": 38398, "ranking": 4 },
                  {"nome": "ANTONIO",  "frequencia": 28739, "ranking": 5 },
                  {"nome": "FRANCISCO", "frequencia": 25426, "ranking": 6 },
                  {"nome": "PEDRO", "frequencia": 21347, "ranking": 7 },
                  {"nome": "CARLOS", "frequencia": 20310, "ranking": 8 },
                  {"nome": "PAULO", "frequencia": 19379, "ranking": 9 },
                  {"nome": "LUCAS", "frequencia": 19258, "ranking": 10 },
                ]}]}
                
  let(:body) {[{"localidade": "BR", "sexo": "null", "res":
             [ {"nome": "CAROL", "frequencia": 11734129, "ranking": 1 },
                {"nome": "JOSE", "frequencia": 5754529, "ranking": 2 },
                {"nome": "ANA", "frequencia": 3089858, "ranking": 3  },
                {"nome": "JOAO", "frequencia": 2984119, "ranking": 4 },
                {"nome": "ANTONIO", "frequencia": 2576348, "ranking": 5 },
                {"nome": "FRANCISCO","frequencia": 1772197,"ranking": 6 },
                {"nome": "CARLOS","frequencia": 1489191,"ranking": 7 },
                {"nome": "PAULO","frequencia": 1423262,"ranking": 8 },
                {"nome": "PEDRO","frequencia": 1219605,"ranking": 9 },
                {"nome": "LUCAS","frequencia": 1127310,"ranking": 10 }
             ]}]}
  let(:base) {"https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking"}
  let(:headers) {{'Accept'=>'*/*',
                  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                  'User-Agent'=>'Faraday v1.0.1'}}

  context 'check GET' do
    it 'GET with successfully body' do
      stub_request(:get, "#{base}?localidade=53").with(headers: headers).
          to_return(status: 200, body: body_df.to_json, headers: {})
          
      stub_request(:get, base).with(headers: headers).
          to_return(status: 200, body: body.to_json, headers: {})

      response = Faraday.get(base)
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq 200

      expect(response_body[0][:res][0][:nome]).to eq("CAROL")
      expect(response_body[0][:res][0][:frequencia]).not_to eq(146770)
      expect(response_body[0][:res][0][:nome]).not_to eq("Maria")
    end

    it 'GET with successfully body_df' do
      stub_request(:get, "#{base}?localidade=53").with(headers: headers).
          to_return(status: 200, body: body_df.to_json, headers: {})
          
      stub_request(:get, base).with(headers: headers).
          to_return(status: 200, body: body.to_json, headers: {})

      response = Faraday.get(base, {localidade: 53})
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq 200

      expect(response_body[0][:res][0][:nome]).to eq("MARIA")
      expect(response_body[0][:res][0][:frequencia]).to eq(146770)
      expect(response_body[0][:res][0][:nome]).not_to eq("CAROL")
    end
  end

  context 'Ranking names by UF' do
    it 'Show response body' do
      stub_request(:get, "#{base}?localidade=53").with(headers: headers).
          to_return(status: 200, body: body_df.to_json, headers: {})

      expect{Name.new.show(base: base,local: 53)}.to output(/MARIA/).to_stdout
      expect{Name.new.show(base: base,local: 53)}.to output(/146770/).to_stdout
      expect{Name.new.show(base: base,local: 53)}.not_to output(/CAROL/).to_stdout
      expect{Name.new.show(base: base,local: 53)}.not_to output(/11734129/).to_stdout
    end

    it 'Show female names' do
      stub_request(:get, "#{base}?localidade=53&sexo=f").with(headers: headers).
          to_return(status: 200, body: body_f.to_json, headers: {})

      expect{Name.new.show(base: base,local: 53,gender: 'f')}.to output(/MARIA/).to_stdout
      expect{Name.new.show(base: base,local: 53,gender: 'f')}.to output(/146770/).to_stdout
      expect{Name.new.show(base: base,local: 53,gender: 'f')}.not_to output(/JOSE/).to_stdout
      expect{Name.new.show(base: base,local: 53,gender: 'f')}.not_to output(/53505/).to_stdout
      expect{Name.new.show(base: base,local: 53,gender: 'f')}.not_to output(/CAROL/).to_stdout
      expect{Name.new.show(base: base,local: 53,gender: 'f')}.not_to output(/11734129/).to_stdout
    end

    it 'Show female names' do
      stub_request(:get, "#{base}?localidade=53&sexo=m").with(headers: headers).
          to_return(status: 200, body: body_m.to_json, headers: {})

      expect{Name.new.show(base: base,local: 53,gender: 'm')}.to output(/JOSE/).to_stdout
      expect{Name.new.show(base: base,local: 53,gender: 'm')}.to output(/53505/).to_stdout
      expect{Name.new.show(base: base,local: 53,gender: 'm')}.not_to output(/MARIA/).to_stdout
      expect{Name.new.show(base: base,local: 53,gender: 'm')}.not_to output(/146770/).to_stdout
    end
  end
end
