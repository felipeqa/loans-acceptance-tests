module User
  class Base
    include HTTParty
    base_uri $loans['api'][$env]
  end

  class HTTPUser < Base
    def self.create_user payload
      headers 'Content-Type' => 'application/json'
      post '/users/create', body: payload
    end

    def self.user_authenticator payload
      headers 'Content-Type' => 'application/json'
      post '/user_token', body: payload
    end

    def self.get_user(token)
      headers 'Authorization' => "Bearer #{token}"
      get '/users/current'
    end

    def self.delete_user(id, token)
      headers 'Authorization' => "Bearer #{token}"
      delete "/user/#{id}"
    end
  end
end
