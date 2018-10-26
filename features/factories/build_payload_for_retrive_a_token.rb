require 'ostruct'
require 'json'

class BuildPayloadForRetriveAToken < OpenStruct
  def to_json
    JSON.generate marshal_dump
  end
end

FactoryBot.define do
  factory :user, class: BuildPayloadForRetriveAToken do
    auth do
      {
        email: get_email,
        password: get_password
      }
    end
  end
end
