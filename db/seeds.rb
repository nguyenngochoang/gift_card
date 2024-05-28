5.times do |i|
  user = User.create!(
    email: "user#{i + 1}@example.com",
    password: 'password'
  )

  puts "User #{user.email} created!"
end
