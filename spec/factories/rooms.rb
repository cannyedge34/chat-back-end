# spec/factories/rooms.rb
FactoryBot.define do
  factory :room do
    title { Faker::Lorem.word }
    created_by { Faker::Number.number(10) }
  end
end