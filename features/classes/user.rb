module User
  class Base
    include HTTParty
    base_uri $loans['api'][$env]
    headers 'Content-Type' => 'application/json'
  end

  class HTTPUser < Base
    def self.create_user payload
      post '/users/create', body: payload
    end
    
    def self.user_authenticator payload
      post '/user_token', body: payload
    end
  end
end
