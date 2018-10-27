Dado("um usuário com um token valido") do
  @admin = create_user
  @token = authenticator_user(@admin)
end

Dado("que o cliente possue todos os dados necessários para criação do empréstimo") do
  @loan = FactoryBot.create(:create_loan).loan
end

Quando("envio todos os dados para o serviço de criação de empréstimo") do
  @loan_response = Loan::HTTPLoan.create_loan(@token, @loan.to_json)
end

Então("o serviço deve criar o empréstimo com sucesso") do
  expect(@loan_response.code).to eq(200)
  expect(@loan_response['data']['name']).to eq(@loan['name'])
  expect(@loan_response['data']['cpf']).to eq(@loan['cpf'])
  expect(@loan_response['data']['total_loans']).to eq(@loan['total_loans'])
  expect(
    @loan_response['data']['quantity_quotas']
  ).to eq(@loan['quantity_quotas'])
  quota_value = @loan['total_loans'] / @loan['quantity_quotas']
  expect(@loan_response['data']['quota_value'].to_i).to eq(quota_value)
end

Dado("que o cliente tem um empréstimo criado") do
  steps %{
      Dado que o cliente possue todos os dados necessários para criação do empréstimo
      Quando envio todos os dados para o serviço de criação de empréstimo
    }
end

Quando("o cliente consultar o serviço de empréstimo informando o ID do empréstimo") do
  id = @loan_response['data']['id']
  @get_loan = Loan::HTTPLoan.get_loan_by_id(id, @token)
end

Então("o serviço deve me retornar as informações do empréstimo criado") do
  expect(@get_loan.code).to eq(200)
  expect(@get_loan['data']).to eq(@loan_response['data'])
end

Quando("removo um empréstimo informando o seu ID") do
  id = @loan_response['data']['id']
  @remove_loan = Loan::HTTPLoan.remove_loan_by_id(id, @token)
  @get_loan = Loan::HTTPLoan.get_loan_by_id(id, @token)
end

Então("o serviço deve remover o empréstimo com sucesso") do
  expect(@remove_loan.code).to eq(200)
  expect(@get_loan.code).to eq(404)
end

Quando("envio todos os dados para o serviço de criação de empréstimo sem o token valido") do
  token_fake = 'ftyvibewscufyjhwsdcxuk2345678-90po!@$%*(O)'
  @response = Loan::HTTPLoan.create_loan(token_fake, @loan.to_json)
end


Então("o serviço não deve criar o empréstimo") do
  expect(@response.nil?).to eq(true)
end

Então("retornar o erro {string}") do |http_code|
  expect(@response.code).to eq(http_code.to_i)
end

Dado("um id de um empréstimo") do
  @id = rand(1..10000)
end

Quando("o cliente consultar o serviço de empréstimo informando o ID do empréstimo sem o token valido") do
  token_fake = 'whahdiauh362541bndus'
  @response = Loan::HTTPLoan.get_loan_by_id(@id, token_fake)
end

Então("o serviço não deve retornar as informações do empréstimo valido") do
  expect(@response.nil?).to eq(true)
end

Quando("removo um empréstimo informando o seu ID sem o token valido") do
  token_fake = 'whahdiauh362541bndus'
  @response = Loan::HTTPLoan.remove_loan_by_id(@id, token_fake)
end

Então("o serviço não deve remover o empréstimo") do
  expect(@response.nil?).to eq(true)
end

Dado("um cliente que possue os dados incompletos para criação do empréstimo{string}{string}{string}{string}") do |name, cpf, total_loan, quantity_quotas|
  @loan = FactoryBot.create(
    :create_loan_invalid_data, name: name, cpf: cpf, total_loans: total_loan,
    quantity_quotas: quantity_quotas
  ).loan
end

Então("devo validar as mensagens de erro {string}{int}") do |msg, http_code|
  expect(@loan_response.code).to eq(http_code)
  expect(@loan_response['message']).to eq(msg)
end
