User.create!(name: "Example User",
  email: "slicehoang@gmail.com",
  password: "slice123456",
  password_confirmation: "slice123456",
  admin: true,
  activated: true,
  activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
  email: email,
  password:  password,
  password_confirmation: password,
  activated: true,
  activated_at: Time.zone.now)
end
