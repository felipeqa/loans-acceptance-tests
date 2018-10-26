Dado("um usuário com um token valido") do
  @admin = FactoryBot.create :create_admin_user
  response = User::Create.create_user @admin.to_json
  expect(response.code).to eq(200)
end

Dado("que o cliente possue todos os dados necessários para criação do empréstimo") do
  @loan = FactoryBot.create(:create_loan).loan
end

Dado("possue um token válido para se comunicar com o serviço") do
  email = @admin['user']['email']
  password = @admin['user']['password']
  build_user = FactoryBot.build(:user, get_email: email, get_password: password).auth
  user_auth_payload = FactoryBot.create(:user, auth: build_user)
  @token = User::Authenticator.user_authenticator user_auth_payload.to_json
  expect(@token.code).to eq(201)
end

Quando("envio todos os dados para o serviço de criação de empréstimo") do
  @loan = FactoryBot.create(:create_loan).loan
  token = @token['jwt']
  @last_response = Loan::Create.create_loan(token, @loan.to_json)
end

Então("o serviço deve criar o empréstimo com sucesso") do
  expect(@last_response.code).to eq(200)
  expect(@last_response['data']['name']).to eq(@loan['name'])
  expect(@last_response['data']['cpf']).to eq(@loan['cpf'])
  expect(@last_response['data']['total_loans']).to eq(@loan['total_loans'])
  expect(
    @last_response['data']['quantity_quotas']
  ).to eq(@loan['quantity_quotas'])
  quota_value = @loan['total_loans'] / @loan['quantity_quotas']
  expect(@last_response['data']['quota_value'].to_i).to eq(quota_value)
end

Dado("que o cliente tem um empréstimo criado") do
  pending # Write code here that turns the phrase above into concrete actions
end

Quando("o cliente consultar o serviço de empréstimo informando o ID do empréstimo") do
  pending # Write code here that turns the phrase above into concrete actions
end

Então("o serviço deve me retornar as informações do empréstimo criado") do
  pending # Write code here that turns the phrase above into concrete actions
end

Quando("envio o serviço de empréstimo informando o ID do empréstimo") do
  pending # Write code here that turns the phrase above into concrete actions
end

Então("o serviço deve remover o empréstimo com sucesso") do
  pending # Write code here that turns the phrase above into concrete actions
end
