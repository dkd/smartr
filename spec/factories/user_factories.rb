#Factory.define :user do |u|
#    u.login 'John3000'
#    u.email 'John@gmailtest.com'
#    u.password 'tester2000'
#    u.password_confirmation 'tester2000'
#    u.is_admin false
#end

FactoryGirl.define do
  
  factory :user do
    login 'John3000'
    email 'John@gmailtest.com'
    password 'tester2000'
    password_confirmation 'tester2000'
    is_admin false
  end
  
  factory :user2, :class => User do
    login "Somebody"
    email Faker::Internet.email
    password 'leanderTaler3000'
    password_confirmation 'leanderTaler3000'
    is_admin false
  end
  
  factory :endless_user, :class => User do
    sequence(:login) {|n| "HansDampf#{n}"}
    sequence(:email) {|n| "hans#{n}@dampf-industries.com"}
    password 'leanderTaler3000'
    password_confirmation 'leanderTaler3000'
    is_admin false
  end
  
end
