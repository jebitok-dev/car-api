FactoryBot.define do
  factory :house do
    title { Faker::Lorem.word }
    created_by { Faker::Number.number(digits: 10) }
  end
end
