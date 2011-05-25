When /^I press localized "([^\"]*)"$/ do |key|
  click_button(I18n.t(key))
end

When /^(?:|I )follow localized "([^\"]*)"$/ do |key|
  click_link(I18n.t(key))
end

When /^(?:|I )follow localized "([^\"]*)" within "([^\"]*)"$/ do |key, parent|
  click_link_within(parent, I18n.t(key))
end

Then /^I should see localized "([^\"]*)"$/ do |key|
  response.should contain(I18n.t(key))
end
