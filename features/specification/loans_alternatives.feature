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
@w
Esquema do Cenário: Tentar criar um empréstimo - Payload com erro
  Dado um usuário com um token valido
  E um cliente que possue os dados incompletos para criação do empréstimo<nome><cpf><total_emprestimo><quantidade_de_parcelas>
  Quando envio todos os dados para o serviço de criação de empréstimo
  Então devo validar as mensagens de erro <mensagem><http_code>

  Exemplos:

  |nome    |cpf         |total_emprestimo  |quantidade_de_parcelas  |mensagem        |http_code|
  |""      |"3232323232"|"45000"           |"10"                    |"Loan not saved"|422      |
  |"Felipe"|""          |"45000"           |"10"                    |"Loan not saved"|422      |
  |"Felipe"|"3232323232"|""                |"10"                    |"Loan not saved"|422      |
  |"Felipe"|"3232323232"|"45000"           |""                      |"Loan not saved"|422      |
  |"Felipe"|"3232323232"|"-45000"          |"10"                    |"Loan not saved"|422      |
  |"Felipe"|"3232323232"|"45000"           |"-10"                   |"Loan not saved"|422      |
