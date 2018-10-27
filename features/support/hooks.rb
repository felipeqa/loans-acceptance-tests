After do
  if @token
    user = User::HTTPUser.get_user @token
    User::HTTPUser.delete_user(user['id'], @token)
  end
end
