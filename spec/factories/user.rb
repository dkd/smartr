Factory.define :user do |u|
  u.login {Faker::Name.last_name}
  u.email {Faker::Internet.email}
  u.password 'benrocks'
  u.password_confirmation 'benrocks'
end

