# treinadev2020-d2_censo_ibge

![Badge](https://img.shields.io/badge/STATUS-PROGRESS-orange)

## Sumário

1. [Motivação](#motivation)


## Descrição do Projeto
_Projeto no qual efetua buscas de nomes comuns nos estados e municípios e frequência dos nomes durante os anos._

A aplicação apresenta tabelas no terminal e o fluco de consultas. No momento tem 3 tipos de consultas em que o usuário pode realizar.
Consulta de nomes por UF - Onde mostra 3 tabelas (tabela do ranking de nomes comuns em uma UF, tabela do ranking de nomes femininos comuns em uma UF e tabela do ranking de nomes femininos comuns em uma UF), mostrando um ranking das pessoas e da quantidade de pessoas que correspondem os nomes.

Consulta de nomes por municipio - Funciona parecido com a consulta de cima, porém, ao ínves de pegar os nomes na UF, pega por municípios e colocas nas 3 tabelas e rankeia.

Consulta por frequência dos nomes nas décadas - Nesta última, exibe apenas uma tabela e exibe o nome ou os nomes em que usuário digita e mostra a frequência de pessoas com aqueles nomes nas décadas de 1930 até 2010.

### Motivação <a name= "motivation"></a>

Este projeto foi desenvolvido no término do curso da terceira turma do TreinaDev, curso da Campus code. Um desafio onde pude aprender novas habilidades de organização, desáfios e de botar em prática os conhecimentos e técnicas aprendidas no curso para o desenvolvimento e aprimorar outras.

Foi utilizado técnicas do desenvolvimento ágil, como a [tabela kanbam](https://github.com/Guifs100/treinadev2020-d2_censo_ibge/projects/1) do próprio Github projects para organizar as tarefass de valor, com bastante TDD e gem de teste para poder guiar e orientar na programação, controle de versionamento com o git.

O projeto está sendo um aprendizado muito grande e ainda mais!

## Requisitos

Para utilizar o projeto é necessário:
  - Ruby 2.6.6
  - Bundler >= 2.1.4
  - Gem >= 3.0.8
  
## Gems

As gems utilizadas foram.
- [Terminal-table](https://github.com/tj/terminal-table) - Utilizada para criar as tabelas no terminal.
- [RSpec](https://github.com/rspec/rspec) - Utilizada para desenvolver os testes da aplicação.
- [Faraday](https://github.com/lostisland/faraday) - Utilizada por fornecer uma interface comum cliente HTTP e processar o ciclo de solicitação / resposta. 
- [Webmock](https://github.com/bblimke/webmock) - Para testes de solicitação e respostas HTTP.
- [Pry-byebug](https://github.com/deivid-rodriguez/pry-byebug) - Para debbugar a aplicação.


## Como Usar
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

### Consultas

A seguir, as consultas da aplicação que tem disponível ao iniciar.
--imagem de inicio

#### Consulta de nomes comuns por UF

A primeira consulta e para acessá-lá, necessita escolher a opção '1' na aplicação
--imagem de uf
Depois digitar a UF que deseja mostra uma tabela com o ranking dos nomes mais comuns do estado, tabela com nomes mais comuns femininos e tabela com nomes masculinos. Conforme nas imagens abaixo.
--imagem do resultado 3

#### Consulta de nomes comuns por Município
A segunda consulta e para acessá-lá, necessita escolher a opção '2' na aplicação. Similar a anterior, também necessita selecionar uma UF e depois aparece os municípios para selecionar.
--imagem municipio

Depois digita o número da opção da cidade que fica ao lado do nome do município e aparece as tabelas, similares com a da opção anterior, porém com os dados da cidade.
--imagem do resultado 3

#### Consulta de frequência do uso dos nomes

A terceira e última consulta, para acessá-lá, necessita escolher a opção '3' na aplicação.
Em seguida, é necessário digitar um ou mais nomes (separados por vírgulas) e exibi a frequencia do nome foi usado durante as décadas.

- :warning: Não pode colocar caracteres especiais e outros simbolos.
- :warning: Não deve utilizar espaço e para separar os nomes por vírgula( , ).
- :warning: A API de nomes, não aceita nome composta na busca.

## Tarefas

- [x] Tabelas para exibir os dados
- [x] Acessas as APIs das referências e coletar os seus dados
- [x] Criar a consulta por UF
- [x] Criar a consulta por municipio
- [x] Criar a consulta da frequência dos nomes com um nomes
- [x] Criar a consulta da frequência dos nomes com mais nomes
- [x] Criar a consulta por UF
- [ ] Salvar os dados da API no banco de dados
- [ ] Utilizar o CSV das referências para incrementar as queries

## Próximos Passos

E tudo isso com mais testes :)
- [ ] Implementar as tarefas restantes.
- [ ] Refatorar o código.

## Referências
1. [API de Localidades](https://servicodados.ibge.gov.br/api/docs/localidades?versao=1)
2. [API de Nomes](https://servicodados.ibge.gov.br/api/docs/censos/nomes?versao=2)
3. [CSV com dados da população](https://campus-code.s3-sa-east-1.amazonaws.com/treinadev/populacao_2019.csv)
