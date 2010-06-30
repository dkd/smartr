Given /^the following accounts:$/ do |accounts|
  Account.create!(accounts.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) account$/ do |pos|
  visit accounts_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end


Given /^a valid user$/ do
  @user = Factory.create(:user, 
                         :login => "tester", 
                         :password => "password", 
                         :password_confirmation => "password", 
                         :email => "tester@gmail.com")
end

When /^I put his login and correct password into the form$/ do
  visit new_user_session_path
  fill_in "user_session_login", :with => @user.login
  fill_in "user_session_password", :with => @user.password
  click_button "user_session_submit"
end

Then /^I should see the following accounts:$/ do |expected_accounts_table|
  expected_accounts_table.diff!(tableish('table tr', 'td,th'))
end
