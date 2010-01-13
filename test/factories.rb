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
  u.password_salt(salt = Authlogic::Random.hex_token)
  u.crypted_password Authlogic::CryptoProviders::Sha512.encrypt("benrocks" + salt)
  u.persistence_token '6cde0674657a8a313ce952df979de2830309aa4c11ca65805dd00bfdc65dbcc2f5e36718660a1d2e68c1a08c276d996763985d2f06fd3d076eb7bc4d97b1e317'
  #u.single_access_token "k3cFzLIQnZ4MHRmJvJzg"
  u.skip_session_maintenance true
end
