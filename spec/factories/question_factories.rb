FactoryGirl.define do
  factory :question do
    name 'How many tests do I have to write?'
    body 'There is still a lot of work ahead. The most important tests in this application are the calculation of the user\'s Reputation'
    tag_list 'testing, ruby'
  end
  
  factory :question2, :class => Question do
    name 'Are there more questions needed?'
    body 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
    tag_list 'testing, rspec'
    association :user, :factory => :user
  end
  
  factory :question3, :class => Question do
    name Faker::Lorem.sentences(3).to_s
    body Faker::Lorem.sentences(10).to_s
    tag_list 'testing, rspec'
    association :user, :factory => :user2
  end
end