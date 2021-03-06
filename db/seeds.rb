User.create!(
        first_name: "Abdelrahman",
        last_name: "Ibrahim",
        password:"123456",
        email: "abdelrahman.ibrahim.009@gmail.com",
        password_confirmation: "123456",
        admin: true,
        activated: true,
        activated_at: Time.zone.now
)
99.times do |n|
  name1 = Faker::Name.name
  name2 = Faker::Name.name
  email = "example-#{n+1}@foo.com"
  User.create!(
      first_name: name1,
      last_name: name2,
      password:"123456",
      email: email,
      password_confirmation: "123456",
      admin: false,
        activated: true,
        activated_at: Time.zone.now
  )
end


users = User.order(:created_at).first(6)

50.times do
  content = Faker::Lorem.sentence(5)
  users.each do |user|
    user.microposts.create!(content: content)
  end

end


users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]

following.each{|f| user.follow(f)}
followers.each{|f| f.follow(user)}



