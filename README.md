### Getting Started

This is a Ruby on rails 5 Actioncable back-end example chat. You can have a look at the video below. You can find the front-end example chat made with vuejs at https://github.com/cannyedge34/chat-front-end.git

This project was bootstrapped with Ruby on Rails 5 and ActionCable. It is not tested in production environment, it is just an example app. So, use it under your responsibility.

Demo Video example: https://youtu.be/JIFLc5XtfeU



Checkout this repo, install dependencies, then start rails server with the following:

```
> git clone https://github.com/cannyedge34/chat-back-end.git
> cd chat-back-end
> bundle install
> rails db:migrate
> rails s
```

``` 
1. Instructions
  Install httpie from https://httpie.org/ or postman from https://www.getpostman.com/
2. Signup a new user and get token from here
  http :3000/signup username=juan password=123
3. Get auth token
  http :3000/auth/login username=juan password=123
3. Get all chat rooms
  http :3000/rooms Authorization:"your_generated_token"
4. Create room for new user
  http --form POST :3000/rooms Accept:'application/vnd.rooms.v1+json' Authorization:"your_generated_token" title="Room 1"
5. Create message for new room
  http --form POST :3000/rooms/1/messages Accept:'application/vnd.messages.v1+json' Authorization:"your_generated_token" content="Message 1"
6. Get all room messages
  http :3000/rooms/1/messages Accept:'application/vnd.messages.v1+json' Authorization:"your_generated_token"
```

# Optional

**Generating Fake Data:**
```
rails db:migrate:reset && rails db:seed
```

**Generating a lot of rooms and messages in seeds.rb**
```
user = User.create(username: Faker::Internet.user_name, password: "123")
10.times do
  room = Room.create(title: Faker::Lorem.word, created_by: user.id)
  3.times do
    room.messages.create(name: Faker::Lorem.word)
  end
end
```

**All test are passed. You should run:**

```bundle exec rspec```
