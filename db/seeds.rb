User.create! name: "Admin", email: "admin@gmail.com",
  password: "123456", password_confirmation: "123456",
  date_of_birth: "21/11/1996", role: 1

50.times do |n|
  name = "User-#{n+1}"
  email = "u#{n+1}@gmail.com"
  password = "123456"
  User.create! name: name, email: email, password: password,
    password_confirmation: password, date_of_birth: "21/11/1996"
end
