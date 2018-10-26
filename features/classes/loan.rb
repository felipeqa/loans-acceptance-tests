module Loan
  class Base
    include HTTParty
    base_uri $loans['api'][$env]
  end

  class HTTPLoan < Base
    headers 'Content-Type' => 'application/json'

    def self.create_loan(token, payload)
      headers 'Authorization' => "Bearer #{token}"
      post '/api/v1/loans', body: payload
    end

    def self.get_loan_by_id(id, token)
      headers 'Authorization' => "Bearer #{token}"
      get "/api/v1/loans/#{id}"
    end
  end
end
