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
  if page.respond_to? :should
    page.should have_content(I18n.t(key))
  else
    assert page.has_content?(I18n.t(key))
  end
end

Then /^I should not see localized "([^\"]*)"$/ do |key|
  if page.respond_to? :should
    page.should_not have_content(I18n.t(key))
  else
    assert page.has_no_content?(I18n.t(key))
  end
end
