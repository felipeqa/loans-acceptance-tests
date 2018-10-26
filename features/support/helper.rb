module Helper

  def create_user
    user = FactoryBot.create :create_admin_user
    response = User::HTTPUser.create_user user.to_json
    expect(response.code).to eq(200)
    return user
  end

  def authenticator_user(user)
    email = user['user']['email']
    password = user['user']['password']
    build_user = FactoryBot.build(:user, get_email: email, get_password: password).auth
    user_auth_payload = FactoryBot.create(:user, auth: build_user)
    token = User::HTTPUser.user_authenticator user_auth_payload.to_json
    expect(token.code).to eq(201)
    return token['jwt']
  end
end

World(Helper)
