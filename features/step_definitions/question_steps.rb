Given /^the following questions:$/ do |questions|
  Question.create!(questions.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) question$/ do |pos|
  visit questions_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following questions:$/ do |expected_questions_table|
  expected_questions_table.diff!(tableish('table tr', 'td,th'))
end
