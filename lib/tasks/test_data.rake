namespace :db do
  desc "Fill database with test data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                 email: "example@mail.ru",
                 password: "123456",
                 password_confirmation: "123456",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@mail.ru"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end