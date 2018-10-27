require 'ostruct'
require 'json'

class CreateLoan < OpenStruct
  def to_json
    JSON.generate marshal_dump
  end

  def faker_name
    Faker::Name.name
  end

  def faker_cpf
    Faker::CPF.numeric
  end

  def rand_total_loan
    rand(1000..10000)
  end

  def rand_quantity_quotas
    rand(1..10)
  end


end

FactoryBot.define do
  factory :create_loan, class: CreateLoan do
    loan do
      {
        'name' => faker_name,
        'cpf' => faker_cpf,
        'total_loans' => rand_total_loan,
        'quantity_quotas' => rand_quantity_quotas
      }
    end
  end

  factory :create_loan_invalid_data, class: CreateLoan do
    loan do
      {
        name: name,
        cpf:  cpf,
        total_loans: total_loans,
        quantity_quotas: quantity_quotas
      }
    end
  end
end
