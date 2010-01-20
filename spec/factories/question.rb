Factory.define :question do |q|
  
  q.name "What is wrong with PHP?"
  q.body "I can't take it anymore! Help!"
  q.tag_list "php, testing"
  q.association(:user)
end
