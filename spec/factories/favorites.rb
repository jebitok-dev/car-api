FactoryBot.define do
  factory :item do
    name { Faker::StarWars.character }
    done false
    house_id nil
  end
end
