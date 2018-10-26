Dado("um usuário com um token valido") do
  @admin = create_user
  @token = authenticator_user(@admin)
end

Dado("que o cliente possue todos os dados necessários para criação do empréstimo") do
  @loan = FactoryBot.create(:create_loan).loan
end

Quando("envio todos os dados para o serviço de criação de empréstimo") do
  @loan = FactoryBot.create(:create_loan).loan
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
  pending # Write code here that turns the phrase above into concrete actions
end

Então("o serviço deve remover o empréstimo com sucesso") do
  pending # Write code here that turns the phrase above into concrete actions
end
