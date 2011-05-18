Given /^I am not authenticated$/ do
  visit('/logout')
end

Given /I am an authenticated user "(.*)"$/ do |name|
  user = User.create( :login => name, 
                      :email => "#{name}@test.com", 
                      :password => "password1010", 
                      :password_confirmation => "password1010")
  And %{I am on the login page}
  And %{I fill in "user_login" with "#{user.login}"}
  And %{I fill in "user_password" with "password1010"}
  And %{I press "Sign in"}
end

Given /there is an user "(.*)"$/ do |name|
  user = User.create( :login => name, 
                      :email => "#{name}@test.com", 
                      :password => "password1010", 
                      :password_confirmation => "password1010")
end