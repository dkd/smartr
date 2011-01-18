FactoryGirl.define do
  factory :answer do
    body 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
  end

  factory :full_answer, :class => Answer do
    body 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
    association :user, :factory => :user2
    association :question, :factory => :question2
  end

end