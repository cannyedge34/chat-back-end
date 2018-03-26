# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(username: Faker::Internet.user_name, password: "123")
10.times do
  room = Room.create(title: Faker::Lorem.word, created_by: user.id)
  3.times do
    room.messages.create(content: Faker::Lorem.word, username: user.username)
  end
end