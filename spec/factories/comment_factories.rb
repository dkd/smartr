FactoryGirl.define do

  factory :comment do
    body "I think these comments should be brief und helpful."
  end
  
  factory :random_comment, :class => Comment do
    body Faker::Lorem.sentence(10).truncate(150)
  end

end