FactoryGirl.define do
  factory :vote do
  end
  factory :upvote, :class => Vote do
    value 1
  end
  factory :downvote, :class => Vote do
    value -1
  end
end