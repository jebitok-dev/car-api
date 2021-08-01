FactoryBot.define do
  factory :favorite do
    name { Faker::Movies::StarWars.character }
    done { false }
    house_id { nil }
  end
end
