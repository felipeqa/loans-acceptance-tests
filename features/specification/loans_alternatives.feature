#encoding: utf-8
#language: pt

@alternative_path
Funcionalidade: Empréstimos - Testes Alternativos

Cenário: Criar Empréstimo não autenticado
  Dado que o cliente possue todos os dados necessários para criação do empréstimo
  Quando envio todos os dados para o serviço de criação de empréstimo sem o token valido
  Então o serviço não deve criar o empréstimo
  E retornar o erro "401"

Cenário: Consultar empréstimo não autenticado
  Dado um id de um empréstimo
  Quando o cliente consultar o serviço de empréstimo informando o ID do empréstimo sem o token valido
  Então o serviço não deve retornar as informações do empréstimo valido
  E retornar o erro "401"

Cenário: Remover empréstimo não autenticado
  Dado um id de um empréstimo
  Quando removo um empréstimo informando o seu ID sem o token valido
  Então o serviço não deve remover o empréstimo
  E retornar o erro "401"
