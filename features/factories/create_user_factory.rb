require 'ostruct'
require 'json'

class CreateUser < OpenStruct
  def to_json
    JSON.generate marshal_dump
  end

  def email
    Faker::Internet.email
  end
end

FactoryBot.define do
  factory :create_admin_user, class: CreateUser do
    user do
      {
        'email' => email,
        'password' => 'password',
        'username' => "admin#{email}",
        'role' => 'admin'
      }
    end
  end
end
