FactoryGirl.define do
  factory :answer do
    body 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
  end
  
  factory :answer_on_my_own_question, :class => Answer do
    body 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
    association :user, :factory => :user
    association :question, :factory => :question2
  end
  
  factory :answer_other_users_question, :class => Answer do
    body 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
    association :user, :factory => :user
    association :question, :factory => :question3
  end

end