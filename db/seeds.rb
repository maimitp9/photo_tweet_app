# create user
User.create(user_name: 'test_user', password: '123456', password_confirmation: '123456')
User.create(user_name: 'user_2', password: '123456', password_confirmation: '123456')
puts "2 user created"