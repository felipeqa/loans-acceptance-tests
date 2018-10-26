require 'rspec'
require 'cucumber'
require 'pry'
require 'httparty'
require 'factory_bot'
require 'faker'
require 'cpf_faker'

$env = ENV['ENV'] || 'prod'
puts 'Working on ' + $env

$loans = {
  'api' => {
    'local' => 'localhost:3000',
    'prod' => 'https://loans-api-felipe-qa.herokuapp.com'
  }
}

World(FactoryBot::Syntax::Methods)
