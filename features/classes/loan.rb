module Loan
  class Base
    include HTTParty
    base_uri $loans['api'][$env]
  end

  class Create < Base
    headers 'Content-Type' => 'application/json'

    def self.create_loan(token, payload)
      headers 'Authorization' => "Bearer #{token}"
      post '/api/v1/loans', body: payload
    end
  end
end
