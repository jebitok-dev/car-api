FactoryBot.define do
    factory :user do
      name { 'CarKE' }
      email { Faker::Internet.email }
      password { '12345678' }
    end
end