- Foi criada uma interface chamada IDadosCep para servir como delimitadora  dos dados a serem preenchidos na busca pelo CEP, sendo disponibilizados para acesso pós busca: o Endereço, o Bairro, a Cidade a UF e o próprio CEP.
Para minimizar as possibilidade de não haver um retorno da referida informação foram usadas 3 (três) API para fazer a consulta, sendo que se uma delas apresentar alguma falha ou não conseguir achar o referido CEP a busca será realizada na outra API senquencialmente até obter uma resposta ou não obter nenhuma resposta como retorno onde então será informado que não foi localizado o referido CEP. A sequência de busca está informada abaixo, onde o [CEP] deve ser substituído pelo CEP correspondente:

1) https://viacep.com.br/ws/[CEP]/json
2) https://cdn.apicep.com/file/apicep/[CEP].json
3) https://cep.awesomeapi.com.br/json/[CEP]

