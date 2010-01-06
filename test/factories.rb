require "faker"

Factory.define :question do |q|
  q.name "What is going on?"
  q.body "Here is a lot to be seen"
  q.tag_list "test, smartr"
  q.association :user
end

Factory.define :user do |u|
  u.login Faker::Name.last_name
  u.email Faker::Internet.email
  u.password 'benrocks'
  u.password_confirmation 'benrocks'
  u.password_salt 'CVVMAm9XxdwXpURdQG1N'
  u.crypted_password 'fb2454b8d22edacc6e88a55972ed5a...'
  u.persistence_token '6cde0674657a8a313ce952df979de2830309aa4c11ca6...'
  #u.single_access_token "k3cFzLIQnZ4MHRmJvJzg"
end
