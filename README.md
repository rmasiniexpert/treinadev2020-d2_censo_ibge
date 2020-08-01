# treinadev2020-d2_censo_ibge

![Badge](https://img.shields.io/badge/STATUS-PROGRESS-orange)

## Sumário

[1. Descrição do Projeto](#descricao)

[2. Motivação](#motivacao)

[3. Requisitos](#requisitos)

[4. Gems](#gems)

[5. Como usar](#como_usar)

[5.1. Consultas](#consultas)
  
[5.1.1. Consulta por UF](#consulta1)
  
[5.1.2. Consulta por município](#consulta2)
  
[5.1.3. Consulta por frequência nas décadas](#consulta3)

[6. Como executar os teste](#teste)

[7. Tarefas](#tarefas)

[7. Próximos Passos](#proximos_passos)

[8. Referências](#referencias)

[9. Licensa](#licensa)

## Descrição do Projeto <a name = "descricao">
_Projeto no qual efetua buscas de nomes comuns nos estados e municípios e frequência dos nomes durante os anos._

A aplicação apresenta tabelas no terminal e o fluco de consultas. No momento tem 3 tipos de consultas em que o usuário pode realizar.

Consulta de nomes por UF - Onde mostra 3 tabelas (tabela do ranking de nomes comuns em uma UF, tabela do ranking de nomes femininos comuns em uma UF e tabela do ranking de nomes femininos comuns em uma UF), mostrando um ranking das pessoas e da quantidade de pessoas que correspondem os nomes.

Consulta de nomes por municipio - Funciona parecido com a consulta de cima, porém, ao ínves de pegar os nomes na UF, pega por municípios e colocas nas 3 tabelas e rankeia.

Consulta por frequência dos nomes nas décadas - Nesta última, exibe apenas uma tabela e exibe o nome ou os nomes em que usuário digita e mostra a frequência de pessoas com aqueles nomes nas décadas de 1930 até 2010.

## Motivação <a name= "motivacao">

Este projeto foi desenvolvido no término do curso da terceira turma do TreinaDev, curso da Campus code. Um desafio onde pude aprender novas habilidades de organização, desáfios e de botar em prática os conhecimentos e técnicas aprendidas no curso para o desenvolvimento e aprimorar outras.

Foi utilizado técnicas do desenvolvimento ágil, como a [tabela kanbam](https://github.com/Guifs100/treinadev2020-d2_censo_ibge/projects/1) do próprio Github projects para organizar as tarefass de valor, com bastante TDD e gem de teste para poder guiar e orientar na programação, controle de versionamento com o git.

O projeto está sendo um aprendizado muito grande e ainda mais!

## Requisitos <a name= "requisitos">

Para utilizar o projeto é necessário:
  - Ruby 2.6.6
  - Bundler >= 2.1.4
  - Gem >= 3.0.8


## Gems <a name= "gems">


As gems utilizadas foram.
- [Terminal-table](https://github.com/tj/terminal-table) - Utilizada para criar as tabelas no terminal.
- [RSpec](https://github.com/rspec/rspec) - Utilizada para desenvolver os testes da aplicação.
- [Faraday](https://github.com/lostisland/faraday) - Utilizada por fornecer uma interface comum cliente HTTP e processar o ciclo de solicitação / resposta. 
- [Webmock](https://github.com/bblimke/webmock) - Para testes de solicitação e respostas HTTP.
- [Pry-byebug](https://github.com/deivid-rodriguez/pry-byebug) - Para debbugar a aplicação.


## Como Usar <a name = "como_usar"></a>
 No terminal, clone o projeto na pasta que queira o projeto e rode o seguinte comando:
 
 ~~~ 
 $ git clone https://github.com/Guifs100/treinadev2020-d2_censo_ibge 
 ~~~
 Acesse a pasta do projeto
 ~~~
 $ cd treinadev2020-d2_censo_ibge
 ~~~
 Instale todas as dependências 
 ~~~
 $ bin/setup
 ~~~
 Inicie a aplicação
 ~~~
 ruby censo_ibge.rb 
 ~~~

### Consultas <a name = "consultas"></a>

A seguir, as consultas da aplicação que tem disponível ao iniciar.

![seleciona query](https://github.com/Guifs100/treinadev2020-d2_censo_ibge/blob/master/assets/select_query.png)

#### Consulta de nomes comuns por UF <a name = "consulta1"></a>

A primeira consulta e para acessá-lá, necessita escolher a opção '1' na aplicação

![Tabela de UF](https://github.com/Guifs100/treinadev2020-d2_censo_ibge/blob/master/assets/ufs.png)

Depois digitar a UF que deseja mostra uma tabela com o ranking dos nomes mais comuns do estado, tabela com nomes mais comuns femininos e tabela com nomes masculinos. Conforme nas imagens abaixo.

![Tabela 1 por UF](https://github.com/Guifs100/treinadev2020-d2_censo_ibge/blob/master/assets/t1_query1.png)
![Tabela 2 por UF feminino](https://github.com/Guifs100/treinadev2020-d2_censo_ibge/blob/master/assets/t2_query1.png)
![Tabela 3 por UF masculino](https://github.com/Guifs100/treinadev2020-d2_censo_ibge/blob/master/assets/t2_query1.png)

#### Consulta de nomes comuns por Município <a name = "consulta2"></a>

A segunda consulta e para acessá-lá, necessita escolher a opção '2' na aplicação. Similar a anterior, também necessita selecionar uma UF e depois aparece os municípios para selecionar.

![Tabela de municipio](https://github.com/Guifs100/treinadev2020-d2_censo_ibge/blob/master/assets/select_city.png)

Depois digita o número da opção da cidade que fica ao lado do nome do município e aparece as tabelas, similares com a da opção anterior, porém com os dados da cidade.

![Tabela 1 por município](https://github.com/Guifs100/treinadev2020-d2_censo_ibge/blob/master/assets/t1_query2.png)
![Tabela 2 por município feminino](https://github.com/Guifs100/treinadev2020-d2_censo_ibge/blob/master/assets/t2_query2.png)
![Tabela 3 por município masculino](https://github.com/Guifs100/treinadev2020-d2_censo_ibge/blob/master/assets/t3_query2.png)

#### Consulta de frequência do uso dos nomes <a name = "consulta3"></a>

A terceira e última consulta, para acessá-lá, necessita escolher a opção '3' na aplicação.
Em seguida, é necessário digitar um ou mais nomes (separados por vírgulas) e exibi a frequencia do nome foi usado durante as décadas.

- :warning: Não pode colocar caracteres especiais e outros simbolos.
- :warning: Não deve utilizar espaço e para separar os nomes por vírgula( , ).
- :warning: A API de nomes, não aceita nome composta na busca.

![Tabela 1 com 1 nome](https://github.com/Guifs100/treinadev2020-d2_censo_ibge/blob/master/assets/t1_query3_one_name.png)
![Tabela 1 com 2 nomes](https://github.com/Guifs100/treinadev2020-d2_censo_ibge/blob/master/assets/t1_query3_two_names.png)

#### Como executar os teste <a name = "teste"></a>

Para executar todos os testes, basta estar na pasta raiz do projeto e executar o rspec.
~~~
cd treinadev2020-d2_censo_ibge
rspec
~~~

## Tarefas <a name = "tarefas"></a>

- [x] Tabelas para exibir os dados
- [x] Acessas as APIs das referências e coletar os seus dados
- [x] Criar a consulta por UF
- [x] Criar a consulta por municipio
- [x] Criar a consulta da frequência dos nomes com um nomes
- [x] Criar a consulta da frequência dos nomes com mais nomes
- [x] Criar a consulta por UF
- [ ] Salvar os dados da API no banco de dados
- [ ] Utilizar o CSV das referências para incrementar as queries

## Próximos Passos <a name = "proximos_passos"></a>

E tudo isso com mais testes :)
- [ ] Implementar as tarefas restantes.
- [ ] Refatorar o código.

## Referências  <a name = "referencias"></a>

1. [API de Localidades](https://servicodados.ibge.gov.br/api/docs/localidades?versao=1)
2. [API de Nomes](https://servicodados.ibge.gov.br/api/docs/censos/nomes?versao=2)
3. [CSV com dados da população](https://campus-code.s3-sa-east-1.amazonaws.com/treinadev/populacao_2019.csv)


## Licensa <a name = "licensa"></a>
