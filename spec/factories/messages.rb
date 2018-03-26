# spec/factories/Messages.rb
FactoryBot.define do
  factory :message do
    content { Faker::Lorem.sentence }
    room_id nil
    created_by nil
  end
end